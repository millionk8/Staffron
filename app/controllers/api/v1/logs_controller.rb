module Api::V1
  class LogsController < ApplicationController
    before_action :authenticate_user!

    def index
      if params[:time_log_id]
        base_logs = Log.where(loggable: TimeLog.find(params[:time_log_id]))
      else

        if params[:user_id]
          base_logs = Log.where(author_id: params[:user_id])
        else
          base_logs = Log.where(author_id: current_user.company.users.ids)
        end
      end

      logs, meta = LogsFetcher.new(base_logs, params).fetch

      render json: logs, root: 'entities', meta: meta
    end

  end
end