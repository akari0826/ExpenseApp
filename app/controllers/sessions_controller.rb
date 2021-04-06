class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email_params)
    if user && user.authenticate(password_params[:password])
      log_in(user)
      
      # 管理者の場合
      if user.admin
        redirect_to admin_expenses_url, success: '管理者としてログインに成功しました'
        
      # 一般ユーザの場合
      else
        redirect_to expenses_url, success: 'ログインに成功しました'
      end
      
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def email_params
    params.require(:session).permit(:email)
  end
  
  def password_params
    params.require(:session).permit(:password)
  end
end
