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

# An ERB template renderer class -
# initialize it with the ERB template as a String and
# the current binding for instance variable discovery then
# call TemplateRenderer#render to get the rendered ERB.
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
end

# The User mailer, we'll use this to notify a User about something.
# That something can be anything, no limits to imagination!
class UserMailer < ActionMailer::Base

  def notification_mail
    @user = params[:user]
    subject = "Notification for #{@user.name}"
    template_renderer = TemplateRenderer.new(File.read('misc/notification_mail.erb'), binding)
    mail from: email_address_with_name('support@example.com', 'Support'),
         to: email_address_with_name(@user.email, @user.name),
         subject: subject,
         content_type: 'text/html',
         body: template_renderer.render
  end
end

user = User.select(:name, :email).first!
UserMailer.with(user: user).notification_mail.deliver_now
