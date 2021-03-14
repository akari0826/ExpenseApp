class UsersController < ApplicationController
  # before_action :authenticate_user

  def new
    @user = User.new
  end
  
  def create
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      
      #新規登録したユーザにメール認証を送る
      UserMailer.with(user: @user).account_activation.deliver
      redirect_to root_url, success: '登録が完了しました。登録したメールアドレスにメール認証を送信しました'
    else
      flash.now[:danger] = '登録が失敗しました'
      render :new
    end
  end
  
  # メール認証を完了する
  # def authenticate_completed
  #   # binding.pry
  #   # 認証メールのリンクからトークンを取得してそのトークンを持つユーザーを探す
  #   @user = User.find_by(params[:token])
  #   if @user = User.find_by(token: true) # if tokenがtrue
  #     @user.created_at = Time.current
  #     @user.save
  #     redirect_to login_path, success: 'メール認証に成功しました'
  #   else
  #     redirect_to root_url, danger: 'メール認証に失敗しました'
  #   end
  # end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
