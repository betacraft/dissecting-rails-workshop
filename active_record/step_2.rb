require 'erb'

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

User = Struct.new(:name, :email, keyword_init: true)

if __FILE__ == $0
  @user = User.new name: 'Example User', email: 'user@example.com'
  template_renderer = TemplateRenderer.new(File.read('misc/notification_mail.erb'), binding)
  File.open('misc/mail.html', 'w') { |f| f.write template_renderer.render }
end
