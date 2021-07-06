module Api::V1
  class HolidaysController < ApplicationController
    before_action :authenticate_user!

    def index
      @holidays = HolidaysService.new.call
    end

    def create
    end
  end
end