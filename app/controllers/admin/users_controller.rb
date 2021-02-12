class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  
  def index
    #binding.pry
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update!(user_params)
      redirect_to admin_users_url, success: 'ユーザ更新に成功しました'
    else
      flash.now[:danger] = 'ユーザ更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_url, success: 'ユーザーを削除しました'
  end
  
  private
  def if_not_admin
    redirect_to root_url unless current_user.admin?
  end
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
