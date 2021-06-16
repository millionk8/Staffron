class Api::V1::Overrides::PasswordsController < DeviseTokenAuth::PasswordsController

  protected

  def render_edit_error
    reset_password_url = URI.join(params[:redirect_url], "/reset-password?token_expired=true&token=#{params[:reset_password_token]}").to_s
    
    head :found, location: reset_password_url
  end
end