class Admin::GuestSessionsController < ApplicationController
  
  def create
    user = User.find_by(email: ENV['TEST_ADMIN_EMAIL'])
    user && user.authenticate(password: ENV['TEST_ADMIN_PASSWORD'])
    log_in(user)
    redirect_to admin_expenses_url, success: 'ゲスト管理者としてログインしました'
  end
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
end
