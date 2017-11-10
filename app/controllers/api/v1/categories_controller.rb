module Api::V1
  class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, except: [:index, :create]

    # GET /api/categories
    def index
      categories = BillingCategory.visible.where(app: @current_app, company: current_company)

      render json: categories, root: 'entities'
    end

    # GET /api/categories/:id
    def show
      authorize @category

      render json: @category, root: 'entity'
    end

    # POST /api/categories
    def create
      authorize Category

      category = Category.new(category_params)
      category.company = current_user.company
      if category.save
        render json: category, root: 'entity'
      else
        render json: { status: false, errors: category.errors }, status: :unprocessable_entity
      end
    end

    # PUT /api/categories/:id
    def update
      authorize @category

      if @category.update(category_params)
        render json: @category, root: 'entity'
      else
        render json: { status: false, errors: @category.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /api/categories/:id
    def destroy
      authorize @category

      if @category.destroy
        render json: @category, root: 'entity'
      else
        render json: { status: false, message: 'There was a problem while deleting category' }, status: :unprocessable_entity
      end

    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.permit(:type, :app_id, :name, :status)
    end
  end
end
