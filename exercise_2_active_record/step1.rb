require 'active_record'
require 'action_mailer'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3',
                                        database: 'exercise_2_active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

# The User class that we'll be using in the solution
class User < ActiveRecord::Base
end

# Part 1
puts "User.count : #{User.count :id}"

# Part 2
puts "First User: #{User.first.inspect}"
puts "Last User: #{User.last.inspect}"
