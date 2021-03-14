class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user, :logged_in?, :current_user?
  add_flash_types :success, :info, :warning, :danger
  
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  # 現在ログイン中のユーザーを返す(いる場合)
  def current_user
    
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    
    # 署名付きクッキー
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  private
  def if_not_admin
    redirect_to root_url unless current_user.admin?
  end
end
