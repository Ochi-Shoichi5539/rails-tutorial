class ApplicationController < ActionController::Base
  before_action :login_required

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
      flash[:alert] = "ログインして下さい"
      redirect_to login_url
    end
  end
end
