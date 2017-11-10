class CompanySerializer < ActiveModel::Serializer
  attributes :id,
             :uuid,
             :name,
             :address,
             :address2,
             :city,
             :state,
             :zip,
             :country

   has_many :app_memberships

end
