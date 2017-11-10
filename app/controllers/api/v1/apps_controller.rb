module Api::V1
  class AppsController < ApplicationController
    before_action :authenticate_user!

    # GET /api/apps
    def index
      apps = App.all

      render json: apps, root: 'entities'
    end

    # GET /api/apps/:id
    def show
      app = App.find(params[:id])

      render json: app, root: 'entity'
    end

  end
end