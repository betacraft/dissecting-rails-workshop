require 'action_mailer'
require 'erb'

class UserMailer < ActionMailer::Base
  default from: 'user@example.com'

  def notification_mail
    @user = params[:user]
    subject = "Notification for #{@user.name}"
    mail to: @user.email,
         subject:,
         content_type: 'text/html',
         body: notification_mail_body
  end

  private

  # @param [User] user
  # @return [String]
  def notification_mail_body
    template = ERB.new(File.read(File.join(File.basename(__dir__), 'user_mailer/notification_mail.erb')))
    template.result binding
  end
end
