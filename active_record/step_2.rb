require 'open-uri'
require 'active_record'
require 'action_mailer'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

# The User class that we'll be using in the solution
class User < ActiveRecord::Base

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

if __FILE__ == $0
  puts "We have #{User.count :id} Users to start with..."
  puts "Let's try and list them out:"
  User.find_each do |user|
    puts "id: #{user.id}, name: #{user.name}, email: #{user.email}"
  end
end
