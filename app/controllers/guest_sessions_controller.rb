class GuestSessionsController < ApplicationController
  
  def create
    binding.pry
    user = User.find_by(email: ENV['TEST_EMAIL'])
    user && user.authenticate(password: ENV['TEST_PASSWORD'])
    log_in(user)
    redirect_to expenses_url, success: 'ゲストユーザとしてログインしました'
  end
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
end
