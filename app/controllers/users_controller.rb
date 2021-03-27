class UsersController < ApplicationController
  before_action :authenticate_user

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録が失敗しました'
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
