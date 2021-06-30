class ClockoutWorker
  include Sidekiq::Worker

  def perform(time_log_id)
    time_log = TimeLog.find(time_log_id)

    if time_log.stale?
       time_log.update_attributes(stopped_at: Time.current, note: "AUTOMATIC CLOCK OUT DUE TO 12 HOUR LIMIT BEING REACHED")

       TimeLogMailer.delay.clock_out_email(time_log)
    end
  end
end