module Api::V1
  class PtosController < ApplicationController
    before_action :authenticate_user!
    before_action :find_pto, only: [:show, :update, :destroy]

    # GET /api/ptos
    def index
      ptos, meta = PtosFetcher.new(policy_scope(Pto), params).fetch

      render json: ptos, root: 'entities', meta: meta
    end

    # GET /api/ptos/rejected/:id
    def rejected
      ptos = policy_scope(Pto).where(user_id: params[:user_id], status: 'rejected')
      render json: ptos, root: 'entities'
    end
    
    # GET /api/ptos/pending
    def pending
      ptos = policy_scope(Pto).where(status: 'pending')
      render json: ptos, root: 'entities'
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

        PtoMailer.new_request(pto).deliver_now
        LoggingManager.new(request).log(current_user, pto, Log.actions[:pto_created])

        render json: pto, root: 'entity'
      else
        render json: { status: false, errors: pto.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/ptos/:id
    def update
      authorize @pto
      
      if @pto.update(ptos_params)
        comments_attributes = params[:comments_attributes]
        @pto.comments.create(author: current_user, text: comments_attributes[:text], label: comments_attributes[:label]) if comments_attributes
        send_email(@pto, comments_attributes&.dig(:text))

        render json: @pto, root: 'entity'
      else
        render json: { status: false, errors: @pto.errors.full_messages }, status: :unprocessable_entity
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

    def send_email(pto, comment)
      if pto.status == 'approved'
        PtoMailer.pto_approved(pto, current_user.profile, comment).deliver_now
      elsif pto.status == 'rejected'
        PtoMailer.pto_rejected(pto, current_user.profile, comment).deliver_now
      end
    end
  end
end
