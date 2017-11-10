module Api::V1
  class PackagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_package

    # PUT /api/packages/:uuid/select
    def select
      authorize Package
      app_membership = AppMembershipManager.new(current_company, @package).create
      if app_membership.persisted?
        render json: @package, root: 'entity'
      else
        render json: { status: false, errors: app_membership.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_package
      @package = Package.find_by(uuid: params[:id])
    end

  end
end
