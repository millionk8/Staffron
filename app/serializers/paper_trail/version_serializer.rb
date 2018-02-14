class PaperTrail::VersionSerializer < ActiveModel::Serializer
  attributes :id,
             :item_type,
             :item_id,
             :event,
             :created_at,
             :model,
             :user_id,
             :user

  def model
    "#{object.reify.class.name}Serializer".constantize.new(object.reify)
  end

  def user_id
    object.whodunnit.to_i
  end

  def user
    UserSerializer.new(User.find(object.whodunnit))
  end
end