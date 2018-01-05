class CategorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :type,
             :editable,
             :default,
             :status

  attribute :app_id
  attribute :company_id

end
