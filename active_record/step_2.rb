require 'erb'

# User struct that has the name and email
User = Struct.new(:name, :email, keyword_init: true)

# just pass it along the ERB template
# as a String and the current binding for instance variable
# discovery and then call ERB#result to get the
# rendered ERB.
@user = User.new name: 'Example User', email: 'user@example.com'

template_file = File.read('misc/notification_mail.erb')
erb_template = ERB.new template_file
File.open('misc/mail.html', 'w') { |f| f.write erb_template.result(binding) }
