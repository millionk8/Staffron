module Api::V1
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile

    # PUT /api/profiles/:id
    def update
      authorize @profile

      if @profile.update(profile_params)
        render json: @profile, root: 'entity'
      else
        render json: { status: false, errors: @profile.errors }, status: :unprocessable_entity
      end
    end

    private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.permit(:first_name, :last_name, :ssn, :address, :address2, :city, :state, :zip, :phone, :title)
    end
  end
end
