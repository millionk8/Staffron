module Api::V1
  class TimesheetsController < ApplicationController
    before_action :authenticate_user!

    # GET /api/timesheets
    def index
      timesheets = policy_scope(Timesheet).order('created_at DESC')

      render json: timesheets, root: 'entities'
    end

    # GET /api/timesheets/:id
    def show
      timesheet = Timesheet.find(params[:id])
      authorize timesheet

      render json: timesheet, root: 'entity'
    end

    # POST /api/timesheets
    def create
      authorize Timesheet
      timesheet = Timesheet.new(timesheet_params)
      timesheet.user = current_user

      if timesheet.save
        render json: timesheet, root: 'entity'
      else
        render json: { status: false, errors: timesheet.errors }, status: :unprocessable_entity
      end
    end

    # PUT /api/timesheets/:id
    def update
      timesheet = Timesheet.find(params[:id])
      authorize timesheet

      if timesheet.update(timesheet_params)
        render json: timesheet, root: 'entity'
      else
        render json: { status: false, errors: timesheet.errors }, status: :unprocessable_entity
      end

    end

    # DELETE /api/timesheets/:id
    def destroy
      timesheet = Timesheet.find(params[:id])
      authorize timesheet

      if timesheet.destroy
        render json: timesheet, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while deleting timesheet' }, status: :unprocessable_entity
      end

    end

    private

    def timesheet_params
      params.permit(:week, :year, :status, :note)
    end

  end

end