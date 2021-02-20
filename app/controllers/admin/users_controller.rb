class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  
  def index
    @users = User.includes(:expenses).search(params[:search])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
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
  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
end
