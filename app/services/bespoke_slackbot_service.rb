class BespokeSlackbotService
  NAME_AND_ICON = {
    username: 'Saffron Bot',
    icon_emoji: ':saffron:'
  }

  GOOD = 'good'
  WARNING = 'warning'
  DANGER = 'danger'

  def initialize(channel = ENV['SLACK_WEBHOOK_CHANNEL'])
    @uri = URI(ENV['SLACK_WEBHOOK_URL'])
    @channel = channel
  end

  def timeclock_event(color, title, user)
    fullname = "#{user.profile.first_name} #{user.profile.last_name}"
    params = {
        attachments: [
            {
                title: title,
                color: color,
                fields: [
                    {
                        title: 'User',
                        value: fullname,
                        short: true
                    }
                ]
            }
        ]
    }
    @params = generate_payload(params)
    self
  end

  def deliver
    begin
      Net::HTTP.post_form(@uri, @params)
    rescue => e
      Rails.logger.error("BespokeSlackbotService: Error when sending: #{e.message}")
    end
  end

  private

  def generate_payload(params)
    {
        payload: NAME_AND_ICON
                     .merge(channel: @channel)
                     .merge(params).to_json
    }
  end
end
