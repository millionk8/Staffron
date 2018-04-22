module Api::V1
  class TimeLogsController < ApplicationController
    before_action :authenticate_user!

    # GET /api/time_logs
    def index
      time_logs = policy_scope(TimeLog).order('created_at DESC')

      if params[:user_id].present?
        time_logs = time_logs.where(user_id: params[:user_id])
      else
        time_logs = time_logs.where(user: current_user)
      end

      if params[:mode] == 'day'
        day = Date.parse(params[:day])
        start = day.beginning_of_day
        stop = day.end_of_day
      elsif params[:mode] == 'week'
        week = params[:week].to_i
        year = params[:year].to_i
        start = (Date.commercial(year, week, 1) - 1.day).beginning_of_day
        stop = (Date.commercial(year, week, 7) - 1.day).beginning_of_day
      elsif params[:mode] == 'custom'
        start = Date.parse(params[:start_date]).beginning_of_day
        stop = Date.parse(params[:end_date]).end_of_day
      else
        today = Time.current
        start = today.beginning_of_day
        stop = today.end_of_day
      end

      time_logs = time_logs.where('(started_at BETWEEN :start AND :stop) OR (stopped_at BETWEEN :start AND :stop)', start: start, stop: stop)

      render json: time_logs, root: 'entities'
    end

    # POST /api/time_logs
    def create
      authorize TimeLog
      time_log = TimeLog.new(time_log_params)
      time_log.user = current_user
      time_log.custom = true

      if time_log.save
        LoggingManager.new(request).log(current_user, time_log, Log.actions[:time_log_created])

        render json: time_log, root: 'entity'
      else
        render json: { status: false, errors: time_log.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # POST /api/time_logs/start
    def start
      authorize TimeLog

      time_log = TimeLog.running(current_user)

      if time_log
        render json: { status: false, errors: 'You cannot clock in because you are already clocked in' }, status: :unprocessable_entity
      else
        time_log = TimeLog.new(time_log_params)
        time_log.user = current_user

        if time_log_params[:started_at].present?
          time_log.actual_started_at = Time.current
        else
          time_log.started_at = Time.current
        end

        if time_log.save
          LoggingManager.new(request).log(current_user, time_log, Log.actions[:time_log_started])

          render json: time_log, root: 'entity'
        else
          render json: { status: false, errors: time_log.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end

    # PUT /api/time_logs/stop
    def stop
      time_log = TimeLog.running(current_user)

      if time_log
        authorize time_log

        if time_log_params[:stopped_at].present?
          time_log.actual_stopped_at = Time.current
          time_log.stopped_at = time_log_params[:stopped_at]
        else
          time_log.stopped_at = Time.current
        end

        # Do not create a new version when the time logs is stopped
        time_log.paper_trail.without_versioning do
          if time_log.save
            LoggingManager.new(request).log(current_user, time_log, Log.actions[:time_log_stopped])

            render json: time_log, root: 'entity'
          else
            render json: { status: false, errors: time_log.errors.full_messages }, status: :unprocessable_entity
          end
        end
      else
        render json: { status: false, errors: 'No started time logs found' }, status: :unprocessable_entity
      end

    end

    # PUT /api/time_logs/:id
    def update
      time_log = TimeLog.find(params[:id])
      authorize time_log

      if time_log.update(time_log_params)
        LoggingManager.new(request).log(current_user, time_log, Log.actions[:time_log_updated])

        render json: time_log, root: 'entity'
      else
        render json: { status: false, errors: time_log.errors.full_messages }, status: :unprocessable_entity
      end

    end

    # DELETE /api/time_logs/:id
    def destroy
      time_log = TimeLog.find(params[:id])
      authorize time_log

      if time_log.update(deleted: true, deleted_at: Time.current)
        LoggingManager.new(request).log(current_user, time_log, Log.actions[:time_log_deleted])

        render json: time_log, root: 'entity'
      else
        render json: { status: false, errors: time_log.errors.full_messages }, status: :unprocessable_entity
      end

    end

    private

    def time_log_params
      params.permit(:category_id, :started_at, :stopped_at, :note)
    end

  end

end