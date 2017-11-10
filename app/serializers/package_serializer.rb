class PackageSerializer < ActiveModel::Serializer
  attributes :id,
             :app_id,
             :uuid,
             :name,
             :machine_name,
             :max_users,
             :active

end
