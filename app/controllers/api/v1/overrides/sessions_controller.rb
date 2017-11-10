class Api::V1::Overrides::SessionsController < DeviseTokenAuth::SessionsController

  protected

  def render_create_success
    render json: @resource, root: 'entity'
  end
end