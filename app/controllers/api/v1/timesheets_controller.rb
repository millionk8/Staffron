module Api::V1
  class TimesheetsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_timesheet, only: [:show, :update, :destroy]

    # GET /api/timesheets
    def index
      timesheets = policy_scope(Timesheet).order('created_at DESC')

      timesheets = timesheets.where(status: params[:status]) if params[:status].present?

      timesheets = timesheets.where(week: params[:week]) if params[:week].present?
      timesheets = timesheets.where(year: params[:year]) if params[:year].present?

      timesheets = timesheets.limit(params[:limit]) if params[:limit].present?

      render json: timesheets, root: 'entities'
    end

    # GET /api/timesheets/:id
    def show
      authorize @timesheet

      render json: @timesheet, root: 'entity'
    end

    # POST /api/timesheets
    def create
      authorize Timesheet

      if current_user.policy_accepted_at
        timesheet = Timesheet.new(timesheet_params)
        timesheet.user = current_user

        if timesheet.save
          comments_attributes = params[:comments_attributes]
          timesheet.comments.create(author: current_user, text: comments_attributes[:text]) if comments_attributes

          LoggingManager.new(request).log(current_user, timesheet, Log.actions[:timesheet_submitted])

          render json: timesheet, root: 'entity'
        else
          render json: { status: false, errors: timesheet.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { status: false, errors: 'You have to accept company policy before submitting this timesheet' }, status: :unprocessable_entity
      end
    end

    # PUT /api/timesheets/:id
    def update
      authorize @timesheet

      if @timesheet.update(timesheet_params)
        comments_attributes = params[:comments_attributes]
        @timesheet.comments.create(author: current_user, text: comments_attributes[:text], label: comments_attributes[:label]) if comments_attributes

        render json: @timesheet, root: 'entity'
      else
        render json: { status: false, errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
      end

    end

    # DELETE /api/timesheets/:id
    def destroy
      authorize @timesheet

      if @timesheet.destroy
        render json: @timesheet, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while deleting timesheet' }, status: :unprocessable_entity
      end

    end

    private

    def find_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    def timesheet_params
      params.permit(:week, :year, :status, :note)
    end

  end

end