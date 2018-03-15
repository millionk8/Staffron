module Api::V1
  class UserMembershipsController < ApplicationController
    before_action :authenticate_user!, except: [:validate_invitation_token]

    # GET /api/apps/:app_id/user_memberships
    def index
      authorize UserMembership
      user_memberships = UserMembership.where(app_id: params[:app_id], company: current_company)

      render json: user_memberships, root: 'entities'
    end

    # POST /api/apps/:app_id/user_memberships
    def create
      authorize UserMembership
      user_membership = UserMembership.new(user_membership_params)
      user_membership.company = current_company

      if params[:user_id].present?
        user = User.find(params[:user_id])
        user_membership.user = user
        user_membership.invitation_email = user.email
      end

      if user_membership.save
        if InvitationManager.new(user_membership).invite
          render json: user_membership, root: 'entity'
        else
          render json: { status: false, errors: 'There was a problem while sending invitation' }, status: :unprocessable_entity
        end
      else
        render json: { status: false, errors: user_membership.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/user_memberships/validate_invitation_token/:invitation_token
    def validate_invitation_token
      token = params[:invitation_token]
      user_membership = UserMembership.find_by(invitation_token: token)

      if user_membership.has_valid_token?
          render json: user_membership, root: 'entity'
      else
        render json: { status: false, errors: 'Invalid or expired invitation token' }, status: :unprocessable_entity
      end

    end

    # PUT /api/user_memberships/:id/resend_invitation
    def resend_invitation
      authorize UserMembership
      user_membership = UserMembership.find(params[:id])
      user = User.find_by(email: user_membership.invitation_email)

      user_membership.update(user: user)

      if user_membership.regenerate_invitation_token && InvitationManager.new(user_membership).invite
        render json: user_membership, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while resending invitation' }, status: :unprocessable_entity
      end

    end

    # DELETE /api/user_memberships/:id
    def destroy
      user_membership = UserMembership.find(params[:id])
      authorize user_membership

      if user_membership.destroy
        render json: user_membership, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while resending invitation' }, status: :unprocessable_entity
      end

    end

    private

    def user_membership_params
      params.permit(:app_id, :role_id, :invitation_email)
    end

  end

end