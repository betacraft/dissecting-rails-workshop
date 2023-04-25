require 'erb'

# User struct that has the name and email
User = Struct.new(:name, :email, keyword_init: true)

# just pass it along the ERB template
# as a String and the current binding for instance variable
# discovery and then call ERB#result to get the
# rendered ERB.
@user = User.new name: 'Example User', email: 'user@example.com'
template = ERB.new File.read('misc/notification_mail.erb')
File.open('misc/mail.html', 'w') { |f| f.write template.result(binding) }
