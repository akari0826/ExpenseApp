class ApplicationMailer < ActionMailer::Base
  default from: ENV['LOGIN_EMAIL']
  layout 'mailer'
end