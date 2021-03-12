class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      
      #新規登録したユーザにメール認証を送る
      UserMailer.with(user: @user).authentication_email.deliver
      
      redirect_to root_url, success: '登録が完了しました。登録したメールアドレスにメール認証を送信しました'
    else
      flash.now[:danger] = '登録が失敗しました'
      render :new
    end
  end
  
  #メール認証を完了する
  def authenticate_completed
    # binding.pry
    @user = User.find_by(params[:token])
    if @user
      @user.regenerate_token
      @user.created_at = Time.current
      @user.save
      redirect_to login_path, success: 'メール認証に成功しました'
    else
      redirect_to root_url, danger: 'メール認証に失敗しました'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :token)
  end
end
