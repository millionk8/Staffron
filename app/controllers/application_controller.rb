class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  serialization_scope :current_user

  before_action :set_paper_trail_whodunnit
  before_action :set_locale
  before_action :set_raven_context
  before_action :set_current_app

  def current_company
    current_user ? current_user.company : null
  end

  def build_error(error)
      if error is_a? String

      else

      end
  end

  private

  def user_not_authorized
    render json: { status: false, errors: I18n.t('messages.not_authorized') }, status: :unauthorized
  end

  def set_locale
    I18n.locale = params[:locale] || (current_user && current_user.locale) ||  I18n.default_locale
  end

  def set_raven_context
    Raven.user_context(id: current_user.id, email: current_user.email) if current_user
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def set_current_app
    @current_app = request.headers['app-uuid'] ? App.find_by(uuid: request.headers['app-uuid']) : nil
  end

end
