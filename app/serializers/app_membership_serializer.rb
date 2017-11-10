class AppMembershipSerializer < ActiveModel::Serializer
  attributes :id,
             :active,
             :canceled_at,
             :created_at,
             :updated_at

  attribute :company_id
  attribute :app_id

  belongs_to :package

end
