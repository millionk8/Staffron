module Api::V1
  class PtosController < ApplicationController
    before_action :authenticate_user!
    before_action :find_pto, only: [:show, :update, :destroy]

    # GET /api/ptos
    def index
      ptos, meta = PtosFetcher.new(policy_scope(Pto), params).fetch

      render json: ptos, root: 'entities', meta: meta
    end

    # GET /api/ptos/:id
    def show
      authorize @pto

      render json: @pto, root: 'entity'
    end

    # POST /api/ptos
    def create
      authorize Pto
      pto = Pto.new(ptos_params)
      pto.user = current_user

      if pto.save
        comments_attributes = params[:comments_attributes]
        pto.comments.create(author: current_user, text: comments_attributes[:text]) if comments_attributes

        LoggingManager.new(request).log(current_user, pto, Log.actions[:pto_created])

        render json: pto, root: 'entity'
      else
        render json: { status: false, errors: pto.errors }, status: :unprocessable_entity
      end
    end

    # PUT /api/ptos/:id
    def update
      authorize @pto

      if @pto.update(ptos_params)
        comments_attributes = params[:comments_attributes]
        @pto.comments.create(author: current_user, text: comments_attributes[:text], label: comments_attributes[:label]) if comments_attributes

        render json: @pto, root: 'entity'
      else
        render json: { status: false, errors: @pto.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /api/ptos/:id
    def destroy
      authorize @pto

      if @pto.destroy
        render json: @pto, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while deleting schedule' }, status: :unprocessable_entity
      end

    end

    private

    def ptos_params
      params.permit(:category_id, :starts_at, :ends_at, :status)
    end

    def find_pto
      @pto = Pto.find(params[:id])
    end

  end
end
