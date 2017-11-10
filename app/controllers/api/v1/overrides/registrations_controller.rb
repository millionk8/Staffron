class Api::V1::Overrides::RegistrationsController < DeviseTokenAuth::RegistrationsController

  protected

  def render_create_success
    render json: @resource, root: 'entity'
  end

  def render_update_success
    render json: @resource, root: 'entity'
  end

  private

  def sign_up_params
    params.permit(*params_for_resource(:sign_up) + [:locale, company_attributes: [:name]])
  end

  def account_update_params
    params.permit(*params_for_resource(:account_update) + [:locale, :timezone])
  end

end