class CommentMailer < ApplicationMailer

  def new_comment(comment)
    @comment = comment

    users = User.joins(:comments).where('comments.commentable_id = :id AND comments.commentable_type = :type AND users.id != :author_id', { id: @comment.commentable_id, type: @comment.commentable_type, author_id: @comment.author_id })

    mail(to: users.map(&:email), subject: 'New comment has been submitted!')
  end

end
