module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_user, only: [:show, :update]

    # GET /api/users
    def index
      authorize User

      users, meta = UsersFetcher.new(policy_scope(User), params).fetch

      render json: users.includes(:user_memberships, :profile, :company), root: 'entities', meta: meta
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
      user.joining_date = Date.today

      if user.save
        render json: user, root: 'entity'
      else
        render json: { status: false, errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/users/:id
    def update
      authorize @user

      if @user.update_attributes(user_params)
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
      attrs = [:email, :password, :password_confirmation, :locale, :timezone, :deactivated, :admin, :master, :employment_type, :joining_date, :remaining_pto_days, :remaining_sickness_days]
      if params[:password].present?
        attrs.push(:password, :password_confirmation) 
        params[:user][:password] = params[:password]
        params[:user][:password_confirmation] = params[:password_confirmation]
      end
      
      params.require(:user).permit(attrs)
    end

    def find_user
      @user = User.find(params[:id])
    end

  end
end

