class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user
  before_action :require_login

  include SessionsHelper

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      current_user.present?
    end

    def require_login
      redirect_to root_path unless logged_in?
    end
end
