class UserMailer < ApplicationMailer
  default from: ENV['LOGIN_EMAIL']
  
  # 管理者が承認した際に送信される
  def approval_email
    @user = params[:user]
    mail(to: @user.email, subject: '承認完了のお知らせ')
  end
  
  # 管理者が承認取消した際に送信される
  def approval_cancellation_email
    @user = params[:user]
    mail(to: @user.email, subject: '承認取消のお知らせ')
  end
  
  # ユーザが申請した際に送信される
  def application_email
    @user = params[:user]
    mail(to: @user.email, subject: '申請のお知らせ')
  end
  
end