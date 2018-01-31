module Api::V1
  class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, except: [:index, :create]

    # GET /api/categories
    def index
      # TODO: Should I add app_id here?
      categories, meta = CategoriesFetcher.new(Category.where(company: current_company), params).fetch

      render json: categories, root: 'entities', meta: meta
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
      category.editable = true
      if category.save
        render json: category, root: 'entity'
      else
        render json: { status: false, errors: category.errors }, status: :unprocessable_entity
      end
    end

    # PUT /api/categories/:id
    def update
      authorize @category

      if @category.editable
        if @category.update(category_params)
          render json: @category, root: 'entity'
        else
          render json: { status: false, errors: @category.errors }, status: :unprocessable_entity
        end
      else
        render json: { status: false, message: 'This category is not editable' }, status: :unprocessable_entity
      end
    end

    # PUT /api/categories/:id/set_default
    def set_default
      authorize @category

      ActiveRecord::Base.transaction do
        categories = Category.where(app: @category.app, company: @category.company, type: @category.type)
        categories.update_all(default: false)

        if @category.update(default: true)
          render json: @category, root: 'entity'
        else
          render json: { status: false, errors: @category.errors }, status: :unprocessable_entity
        end
      end
    end

    # DELETE /api/categories/:id
    def destroy
      authorize @category

      if @category.editable
        if @category.destroy
          render json: @category, root: 'entity'
        else
          render json: { status: false, message: 'There was a problem while deleting category' }, status: :unprocessable_entity
        end
      else
        render json: { status: false, message: 'This category is not editable' }, status: :unprocessable_entity
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
