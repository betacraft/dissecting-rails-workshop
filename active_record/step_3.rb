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

  def notification_mail
    @user = params[:user]
    mail from: email_address_with_name('support@example.com', 'Support'),
         to: email_address_with_name(@user.email, @user.name),
         subject: "Notification for #{@user.name}",
         # content_type: 'text/plain', # this is the default Content Type
         body: "Hi, you have a new notification #{@user.name} <#{@user.email}>!"
  end
end

User = Struct.new(:name, :email, keyword_init: true)

# we are almost there...
@user = User.new name: 'Example User', email: 'user@example.com'
UserMailer.with(user: @user).notification_mail.deliver_now
