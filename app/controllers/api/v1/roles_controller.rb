module Api::V1
  class RolesController < ApplicationController
    before_action :authenticate_user!

    # GET /api/roles
    def index
      roles, meta = RolesFetcher.new(Role.where(app_id: 1), params).fetch

      render json: roles, root: 'entities', meta: meta
    end

    # GET /api/roles/:id
    def show
      authorize @role

      render json: @role, root: 'entity'
    end

    # POST /api/roles
    def create
      authorize Category

      role = Role.new(role_params)
      role.app_id = params[:app_id]
      if role.save
        render json: role, root: 'entity'
      else
        render json: { status: false, errors: 'Error: Role could not be added' }, status: :unprocessable_entity
      end
    end

    # PUT /api/roles/:id
    def update
      authorize @role

      if @role.update(role_params)
        render json: @role, root: 'entity'
      else
        render json: { status: false, errors: 'Error: Role could not be updated' }, status: :unprocessable_entity
      end
    end

    # DELETE /api/roles/:id
    def destroy
      authorize @role

      if @role.destroy
        render json: @role, root: 'entity'
      else
        render json: { status: false, message: 'There was a problem while deleting role' }, status: :unprocessable_entity
      end

    end

    private

    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.permit(:app_id, :name, :machine_name)
    end
  end
end
