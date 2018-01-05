module Api::V1
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_comment, only: [:update, :destroy]

    # GET /api/comments
    def index
      authorize Comment
      comments, meta = CommentsFetcher.new(Comment.all, params).fetch

      render json: comments, root: 'entities', meta: meta
    end

    # POST /api/companies
    def create
      authorize Comment
      comment = Comment.new(comments_params)
      comment.author = current_user

      if comment.save
        # Send email to all other people who commented on this commentable
        CommentMailer.new_comment(comment).deliver_later

        render json: comment, root: 'entity'
      else
        render json: { status: false, errors: comment.errors }, status: :unprocessable_entity
      end
    end

    # PUT /api/comments/:id
    def update
      authorize @comment

      if @comment.update(comment_params)
        render json: @comment, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while updating comment' }, status: :unprocessable_entity
      end

    end

    # DELETE /api/comments/:id
    def destroy
      authorize @comment

      if @comment.destroy
        render json: @comment, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem while deleting comment' }, status: :unprocessable_entity
      end

    end

    private

    def comments_params
      params.permit(:commentable_id, :commentable_type, :label, :text)
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
  end
end
