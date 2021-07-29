module Api::V1
  class PayrollController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def export
      response = PayrollService.new(current_company, params[:start_date], params[:end_date]).call

      render json: response
    end
  end
end