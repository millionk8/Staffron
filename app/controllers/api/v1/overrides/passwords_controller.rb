class Api::V1::Overrides::PasswordsController < DeviseTokenAuth::PasswordsController

  protected

  def render_edit_error
    base_redirect_url = URI.join(params[:redirect_url], "/reset-password?token_expired=true&token=#{params[:reset_password_token]}").to_s
    
    head :found, location: base_redirect_url
  end
end