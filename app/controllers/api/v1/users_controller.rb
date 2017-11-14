module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # GET /api/users
    def index
      authorize User
      users = policy_scope(User)

      render json: users, root: 'entities'
    end

  end

end