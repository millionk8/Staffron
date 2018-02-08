module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # GET /api/users
    def index
      authorize User

      users, meta = UsersFetcher.new(policy_scope(User), params).fetch

      render json: users, root: 'entities', meta: meta
    end

    # GET /api/users/:id
    def show
      user = User.find(params[:id])
      authorize user

      render json: user, root: 'entity'
    end

  end

end