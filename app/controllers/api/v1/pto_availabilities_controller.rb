module Api::V1
  class PtoAvailabilitiesController < ApplicationController
    before_action :authenticate_user!

    # GET /api/users/:user_id/pto_availabilities
    def index
      authorize PtoAvailability
      pto_availabilities = policy_scope(PtoAvailability)

      render json: pto_availabilities, root: 'entities'
    end

    # POST /api/pto_availabilities
    def create
      authorize PtoAvailability

      user_id = pto_availability_params[:user_id]
      year = pto_availability_params[:year]
      categories = params[:categories]

      Category.transaction do
        categories.each do |category_id, total|
          PtoAvailability.create!(user_id: user_id, author: current_user, category_id: category_id, year: year, total: total.to_f)
        end
      end

      render json: { status: true, message: 'PTO Availability has been created' }, status: :ok
    rescue Exception => e
      # TODO: Log exception
      puts e.message
      render json: { status: false, errors: 'There was a problem while updating schedule' }, status: :unprocessable_entity
    end

    # PUT /api/pto_availabilities
    def update
      authorize PtoAvailability

      user_id = pto_availability_params[:user_id]
      year = pto_availability_params[:year]
      categories = params[:categories]

      pto_availabilities = PtoAvailability.where(user_id: user_id, author: current_user, category_id: categories.keys, year: year)

      pto_availabilities.each do |pto_availability|
        total = categories[pto_availability.category_id.to_s]
        pto_availability.update(total: total.to_f)
      end

      render json: pto_availabilities, root: 'entities'
    rescue Exception => e
      # TODO: Log exception
      puts e.message
      render json: { status: false, errors: 'There was a problem while updating schedule' }, status: :unprocessable_entity
    end

    private

    def pto_availability_params
      params.permit(:user_id, :year)
    end
  end
end