require 'open-uri'
require 'active_model'

# The User class that is responsible for validating a row of the CSV file
# that has the first_name, last_name and email headers.
# User#valid? can be called on instances of User to check if the row is valid.
class User

  include ActiveModel::API

  attr_accessor :first_name, :last_name, :email

  # we get access to Active Record validation DSL by simply
  # including the ActiveModel::API module
  # validation can be complex, why not make life simple
  # by delegating some of that validation to Active Model's
  # validation DSL?

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def initialize(attributes = {})
    super
    @errors = ActiveModel::Errors.new(self)
  end
end

user = User.new
puts "user.valid? : #{user.valid?}"
puts "user.errors.inspect : #{user.errors.inspect}"

user.first_name = 'Example'
user.last_name = 'User'
user.email = 'rtdpbetacraft.com'
puts "user.valid? : #{user.valid?}"
puts "user.errors.inspect : #{user.errors.inspect}"

user.email = 'rtdp@betacraft.io'
puts "user.valid? : #{user.valid?}"
puts "user.errors.inspect : #{user.errors.inspect}"
