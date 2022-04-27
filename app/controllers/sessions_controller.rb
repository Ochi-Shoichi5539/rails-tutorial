class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    @user = User.find_by(account: params[:session][:account].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:notice] = "ログインしました"
      redirect_to users_url
    else
      flash.now[:alert] = "無効なアカウントとパスワードの組み合わせです"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    @current_user = nil
  end
end
