class Api::V1::Overrides::ConfirmationsController < DeviseTokenAuth::ConfirmationsController

  def show
    super do |resource|
      LoggingManager.new(request).log(resource, resource, Log.actions[:email_confirmed])
    end
  end

end