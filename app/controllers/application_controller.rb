class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user, :logged_in?, :current_user?
  add_flash_types :success, :info, :warning, :danger
  
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
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
