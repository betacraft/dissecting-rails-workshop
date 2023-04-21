require 'action_mailer'

class UserMailer < ActionMailer::Base
  default from: 'user@example.com'

  def notification_mail
    user = params[:user]
    subject = "Notification for #{user.name}"
    mail to: user.email,
         subject:,
         content_type: 'text/html',
         body: notification_mail_body(user)
  end

  private

  # @param [User] user
  # @return [String]
  def notification_mail_body(user)
    <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Notification Mail</title>
      </head>
      <body>
        <h1>Notification Mail</h1>
        <p>Notification mail for <a href="mailto:#{user.email}">#{user.name}</a> from <a href="mailto:user@example.com">user@example.com</p>
      </body>
      </html>
    HTML
  end
end
