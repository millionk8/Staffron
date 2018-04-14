class AppMembershipSerializer < ActiveModel::Serializer
  attributes :id,
             :active,
             :canceled_at,
             :created_at,
             :updated_at

  attribute :company_id
  attribute :app_id

  belongs_to :app
  belongs_to :package


  class AppSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :machine_name,
               :version,
               :status

  end
end
