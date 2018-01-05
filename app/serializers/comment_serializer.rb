class CommentSerializer < ActiveModel::Serializer
  attributes :id,
             :author_id,
             :commentable_id,
             :commentable_type,
             :label,
             :text,
             :created_at,
             :updated_at

  belongs_to :author

end
