class Admin::UsersController < ApplicationController
  before_action :authenticate_user, :if_not_admin
  
  def index
    @users = User.includes(:expenses).search(user_search_params).page(params[:page]).per(5)
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
    User.find(params[:id]).discard
    redirect_to admin_users_url, success: 'ユーザーを削除しました'
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
  
  def user_search_params
    params.fetch(:search, {}).permit(:name, :email)
  end
end
