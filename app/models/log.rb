class Log < ActiveRecord::Base

  enum action: [:time_log_created,
                :time_log_started,
                :time_log_stopped,
                :time_log_updated,
                :time_log_deleted]

  # Associations
  belongs_to :loggable, polymorphic: true

end