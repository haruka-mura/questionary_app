class TopController < ApplicationController
  skip_before_action :require_login
  before_action :redirect_logged_in_user

  def index
  end

  private
    def redirect_logged_in_user
      redirect_to questions_path if logged_in?
    end
end
