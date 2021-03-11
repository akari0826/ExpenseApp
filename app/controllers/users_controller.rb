class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
  #binding.pry
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録が失敗しました'
      render :new
    end
  end
  
  def authenticate
    @user = current_user?
    UserMailer.with(user: @user).authentication_email.deliver
  end
  
  def authenticate_completed
    @user = User.find_by(params[:token])
    if @user
      @user.regenerate_token
      @user.is_confirmed_at = Time.current
      @user.save!
    else
      redirect_to root_url
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
