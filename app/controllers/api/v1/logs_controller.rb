module Api::V1
  class LogsController < ApplicationController
    before_action :authenticate_user!

    def index
      if params[:time_log_id]
        logs = Log.where(loggable: TimeLog.find(params[:time_log_id]))

        render json: logs, root: 'entities'
      else
        render json: { status: false, errors: 'Association for log not found' }, status: :unprocessable_entity
      end
    end

  end
end