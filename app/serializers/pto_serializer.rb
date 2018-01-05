class PtoSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :category_id,
             :status,
             :starts_at,
             :ends_at,
             :approved_at,
             :rejected_at,
             :created_at,
             :updated_at

  belongs_to :category
  belongs_to :user

end
