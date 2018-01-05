module Api::V1
  class SchedulesController < ApplicationController
    before_action :authenticate_user!

    # GET /api/users/:user_id/schedules
    def index
      authorize Schedule
      schedules = policy_scope(Schedule)

      render json: schedules, root: 'entities'
    end

    # POST /api/schedules
    def create
      authorize Schedule
      schedule = Schedule.new(schedule_params)

      if schedule.save
        render json: schedule, root: 'entity'
      else
        render json: { status: false, errors: schedule.errors }, status: :unprocessable_entity
      end
    end

    # PUT /api/schedules/:id
    def update
      schedule = Schedule.find(params[:id])
      authorize schedule

      if schedule.update(schedule_params)
        render json: schedule, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while updating schedule' }, status: :unprocessable_entity
      end

    end

    # DELETE /api/schedules/:id
    def destroy
      schedule = Schedule.find(params[:id])
      authorize schedule

      if schedule.destroy
        render json: schedule, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while deleting schedule' }, status: :unprocessable_entity
      end

    end
    
    private

    def schedule_params
      params.permit(:user_id, :day, :start_time, :work_length, :break_length)
    end
  end
end