class PtoAvailabilitySerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :author_id,
             :category_id,
             :year,
             :total,
             :created_at,
             :updated_at

  belongs_to :user
  belongs_to :author
  belongs_to :category

end
