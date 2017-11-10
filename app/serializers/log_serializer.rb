class LogSerializer < ActiveModel::Serializer
  attributes :id,
             :loggable_id,
             :loggable_type,
             :action,
             :device_name,
             :browser_name,
             :os_name,
             :ip_address,
             :user_agent,
             :mobile,
             :tablet,
             :robot
end
