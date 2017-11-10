class CategorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :type,
             :status

  attribute :app_id
  attribute :company_id

end
