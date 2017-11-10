class LoggingManager

  def initialize(request)
    @request = request
    @browser = Browser.new(request.user_agent)
  end

  def log(loggable, action)

    Log.create(loggable: loggable,
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