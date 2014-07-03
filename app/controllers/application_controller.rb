class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # @return [User]
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
  helper_method :current_user

  # @return [TrueClass|FalseClass]
  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def require_login
    unless user_signed_in?
      redirect_to login_path,
                  alert: t("messages.not_logged_in")
    end
  end
end
