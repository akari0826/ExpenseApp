class UserMailer < ApplicationMailer
  default from: 'ENV['LOGIN_NAME']'
  
  def approval_email #管理者が承認した際に送信される
    @user = params[:user]
    mail(to: @user.email, subject: '承認完了のお知らせ')
  end
  
  def approval_cancellation_email #管理者が承認取消した際に送信される
    @user = params[:user]
    mail(to: @user.email, subject: '承認取消のお知らせ')
  end
  
  def application_email #ユーザが申請した際に送信される
    @user = params[:user]
    mail(to: @user.email, subject: '申請のお知らせ')
  end
  
end