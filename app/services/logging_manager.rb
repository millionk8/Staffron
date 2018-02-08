class LoggingManager

  def initialize(request)
    @request = request
    @browser = Browser.new(request.user_agent)
  end

  def log(author, loggable, action)
    puts '##########'
    puts author.inspect
    Log.create(author_id: author.id,
               loggable: loggable,
               action: action,
               device_name: @browser.device.name,
               browser_name: @browser.name,
               os_name: @browser.platform.name,
               ip_address: @request.remote_ip,
               user_agent: @request.user_agent,
               mobile: @browser.device.mobile?,
               tablet: @browser.device.tablet?,
               robot: @browser.bot?)

  end

end