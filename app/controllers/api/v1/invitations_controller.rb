module Api::V1
  class InvitationsController < DeviseTokenAuth::RegistrationsController

    # POST /api/invitations
    def create

      user_membership = UserMembership.find_by(invitation_token: params[:invitation_token], invitation_email: params[:email], company_id: params[:company_id])

      if user_membership && user_membership.has_valid_token? && !user_membership.accepted?
        if user_membership.user
          user_membership.update(invitation_token: nil, invitation_accepted_at: Time.current)
        else

          super do |resource|
            # We do not want to send out confirmation email twice
            resource.skip_confirmation!
            user_membership.update(user: resource, invitation_token: nil, invitation_accepted_at: Time.current)

            LoggingManager.new(request).log(resource, user_membership, Log.actions[:invitation_accepted])

          end
        end
      else
        render json: { status: false, errors: 'Invalid or expired invitation token' }, status: :unprocessable_entity
      end

    end

    def sign_up_params
      params.permit(*params_for_resource(:sign_up) + [:company_id, :locale, profile_attributes: [:first_name, :last_name]])
    end

  end


end