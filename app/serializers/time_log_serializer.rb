class TimeLogSerializer < ActiveModel::Serializer
  attributes :id,
             :note,
             :started_at,
             :actual_started_at,
             :stopped_at,
             :actual_stopped_at,
             :custom,
             :created_at,
             :deleted,
             :deleted_at,
             :versions_count,
             :updated_at

  attribute :user_id

  has_one :category

  def versions_count
    object.versions.count
  end

end
