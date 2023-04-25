require 'erb'

class UserEmailBody
  User = Struct.new(:name, :email)
  def initialize(user = nil )
    @user = user || User.new("John Snow", "king_in_the_north@house_stark.com")
    @template_string = File.read("#{__dir__}/user_email_template.erb")
  end

  def call
    TemplateRenderer.new(@template_string).render(binding)
  end
end

class TemplateRenderer
  def initialize(template_string)
    @template = ERB.new(template_string)
  end

  def render(b)
    @template.result(b)
  end

end
