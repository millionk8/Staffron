module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_user, only: [:show, :update]

    # GET /api/users
    def index
      authorize User

      users, meta = UsersFetcher.new(policy_scope(User), params).fetch

      render json: users, root: 'entities', meta: meta
    end

    # GET /api/users/:id
    def show
      authorize @user

      render json: @user, root: 'entity'
    end

    # POST /api/users
    def create
      authorize User

      user = User.new(user_params)
      user.company = current_user.company
      user.admin = user_params[:admin]
      user.master = user_params[:master]

      if user.save
        render json: user, root: 'entity'
      else
        render json: { status: false, errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/users/:id
    def update
      authorize @user
      @user.admin = user_params[:admin]
      @user.master = user_params[:master]
      @user.locale = user_params[:locale]
      @user.timezone = user_params[:timezone]
      if user_params[:password].present?
        @user.password = user_params[:password]
        @user.password_confirmation = user_params[:password_confirmation]
      end

      if @user.save
        render json: @user, root: 'entity'
      else
        render json: { status: false, errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/users/:id
    def destroy
      user = User.find(params[:id])

      if user.destroy
        render json: user, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while disabling user' }, status: :unprocessable_entity
      end

    end

    private

    def user_params
      params.permit(:email, :password, :password_confirmation, :locale, :timezone, :deactivated, :admin, :master)
    end

    def find_user
      @user = User.find(params[:id])
    end

  end
end