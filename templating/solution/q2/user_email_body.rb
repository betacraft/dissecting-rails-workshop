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
  def initialize(obj)
    @user = eval("@user", obj)
    @template = ERB.new(eval("@template_string", obj))
  end

  def render
    @template.result(binding)
  end

end
