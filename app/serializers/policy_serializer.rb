class PolicySerializer < ActiveModel::Serializer
  attributes :id,
             :company_id,
             :text,
             :created_at,
             :updated_at

end
