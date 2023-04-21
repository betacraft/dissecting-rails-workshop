require 'erb'

class UserEmailBody
	User = Struct.new(:name, :email)
	def initialize(user = nil )
		@user = user || User.new("John Snow", "king_in_the_north@house_stark.com")
		@template = ERB.new(File.read("#{__dir__}/user_email_template.erb"))
	end

	def call
		@template.result(binding)
	end
end
