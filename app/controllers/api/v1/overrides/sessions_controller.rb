class Api::V1::Overrides::SessionsController < DeviseTokenAuth::SessionsController

  def create
    super do |resource|
      LoggingManager.new(request).log(resource, resource, Log.actions[:logged_in]) unless resource.admin
    end
  end

  def destroy
    super do |resource|
      LoggingManager.new(request).log(resource, resource, Log.actions[:logged_out]) unless resource.admin
    end
  end

  protected

  def render_create_success
    render json: @resource, root: 'entity'
  end
end