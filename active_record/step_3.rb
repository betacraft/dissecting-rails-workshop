require 'action_mailer'
require 'letter_opener'

# so that mails open up nicely in the browser
ActionMailer::Base.add_delivery_method :letter_opener,
                                       LetterOpener::DeliveryMethod,
                                       location: File.expand_path('tmp/letter_opener', __dir__)
ActionMailer::Base.delivery_method = :letter_opener

# The User mailer, we'll use this to notify a User about something.
# That something can be anything, no limits to imagination!
class UserMailer < ActionMailer::Base

  default from: 'user@example.com'

  def notification_mail
    @user = params[:user]
    subject = "Notification for #{@user.name}"
    mail to: @user.email,
         subject:,
         content_type: 'text/html',
         body: notification_mail_body(@user)
  end

  private

  def notification_mail_body(_user)
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
          <p>Notification mail for <a href="mailto:#{@user.email}">#{@user.name}</a> from <a href="mailto:user@example.com">user@example.com</a></p>
        </body>
      </html>
    HTML
  end
end

User = Struct.new(:name, :email, keyword_init: true)

if __FILE__ == $0
  # we are almost there...
  @user = User.new name: 'Example User', email: 'user@example.com'
  UserMailer.with(user: @user).notification_mail.deliver_now
end
