module Api::V1
  class AppMembershipsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_app

    # POST /api/apps/:app_id/app_memberships
    def create
      authorize AppMembership
      package = @app.packages.find_by(uuid: params[:package_uuid])
      app_membership = AppMembershipManager.new(current_company, package).create

      if app_membership.persisted?
        render json: app_membership, root: 'entity'
      else
        render json: { status: false, errors: app_membership.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /api/apps/:app_id/cancel_subscription
    def destroy
      app_membership = AppMembership.find_by(app: @app, company: current_company, active: true)

      if app_membership
        authorize app_membership
        
        if app_membership.update(active: false, canceled_at: Time.current)
          render json: app_membership, root: 'entity'
        else
          render json: { status: false, errors: app_membership.errors }, status: :unprocessable_entity
        end
      else
        render json: { status: false, errors: 'You are not subscribed to this package' }, status: :unprocessable_entity
      end
    end

    private

    def set_app
      @app = App.find(params[:app_id])
    end

    def app_membership_params
      params.permit(:app_id, :package_id)
    end

  end
end