require 'erb'
require 'active_record'
require 'action_mailer'
require 'letter_opener'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
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
    template_renderer = TemplateRenderer.new(File.read('misc/notification_mail.erb'), binding)
    mail to: @user.email,
         subject:,
         content_type: 'text/html',
         body: template_renderer.render
  end
end

class UserEmailSender

  def self.call
    user = User.select(:name, :email)
               .first!
    UserMailer.with(user:).notification_mail.deliver_now
    { status_code: 200, body: user.to_json }
  end
end

# this code can be put in say lambda_handler.rb
# within an AWS Lambda function
def lambda_handler(event:, context:)
  UserEmailSender.call => { status_code:, body: }
  { status_code:, body: }
end

if __FILE__ == $0
  # fake the Cloud function invocation for now :)
  lambda_handler(event: {}, context: {})
end
