class Api::V1::Overrides::TokenValidationsController < DeviseTokenAuth::TokenValidationsController

  def validate_token
    if @resource
      # Check for specific app
      if @current_app
        user_membership = UserMembership.where(user: @resource, app: @current_app).take

        if user_membership && user_membership.is_valid?
          render_validate_token_success
        else
          render_unauthorized(["You are not authorized to access #{app.name}"], 1)
        end
      else
        # If no app_uuid is provided return success to allow login to gateway app
        render_validate_token_success
      end

    else
      render_unauthorized(['You have to be logged in to access this page'], 0)
    end
  end

  protected

  def render_unauthorized(message, code)
    render json: { status: false, code: code, errors: message }, status: :unauthorized
  end

  def render_validate_token_success
    render json: @resource, root: 'entity'
  end
end