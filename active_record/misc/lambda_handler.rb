# BONUS
# Active Record
# You need write an independent service that runs on AWS Lambda to send out emails. This service will be provided with
# user-id when events trigger - based on those events, you will need to connect with databased, retrieve name and email
# for that user and send out the email.
# NOTE: run the script from within the misc directory.
require 'erb'
require 'active_record'
require 'action_mailer'
require 'letter_opener'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3',
                                        database: File.join(
                                          File.expand_path('..'),
                                          'active_record.sqlite3'
                                        )
Arel::Table.engine = ActiveRecord::Base

# so that mails open up nicely in the browser
ActionMailer::Base.add_delivery_method :letter_opener,
                                       LetterOpener::DeliveryMethod,
                                       location: File.expand_path('tmp/letter_opener', __dir__)
ActionMailer::Base.delivery_method = :letter_opener

# An ERB template renderer, just pass it along the ERB template
# as a String and the current binding for instance variable
# discovery and then call TemplateRenderer#render to get the
# rendered ERB.
class TemplateRenderer

  # @param [String] template_string
  # @param [Binding] calling_context_binding
  def initialize(template_string, calling_context_binding)
    @template = ERB.new template_string
    @calling_context_binding = calling_context_binding
  end

  def render
    @template.result @calling_context_binding
  end
end

# The User class that we'll be using in the solution
class User < ActiveRecord::Base

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

# The User mailer, we'll use this to notify a User about something.
# That something can be anything, no limits to imagination!
class UserMailer < ActionMailer::Base

  default from: 'user@example.com'

  def notification_mail
    @user = params[:user]
    subject = "Notification for #{@user.name}"
    template_renderer = TemplateRenderer.new(File.read('notification_mail.erb'), binding)
    mail to: @user.email,
         subject:,
         content_type: 'text/html',
         body: template_renderer.render
  end
end

class UserEmailSender

  def self.call(user_id)
    user = User.select(:name, :email)
               .find user_id
    UserMailer.with(user:).notification_mail.deliver_now
    { status_code: 200, body: user.to_json }
  end
end

def lambda_handler(event:, context:)
  UserEmailSender.call(event['user_id']) => { status_code:, body: }
  { status_code:, body: }
end

# lambda_handler(event: { 'user_id' => 1 }, context: {})
