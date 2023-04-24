require 'erb'
require 'active_record'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

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

if __FILE__ == $0
  @user = User.first!
  template_renderer = TemplateRenderer.new(File.read('misc/notification_mail.erb'), binding)
  File.open('misc/mail.html', 'w') { |f| f.write template_renderer.render }
end
