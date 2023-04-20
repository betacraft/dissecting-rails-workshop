#!/usr/bin/env ruby
require 'active_support/core_ext/hash/indifferent_access'
require_relative 'config'
require_relative 'models/user'
require 'json'

class UserEmailSender
  def self.call(user_id)
    new(user_id).call
  end
  private_class_method :new

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    user = User.select(:name, :email)
               .find @user_id
    # UserMailer.demo_mail.deliver_now
    { status_code: 200, body: user.to_json }
  end
end

# this code can be put in say lambda_handler.rb
# within an AWS Lambda function
def lambda_handler(event:, context:)
  UserEmailSender.call(event['user_id'].to_i) => { status_code:, body: }
  { status_code:, body: }
end

if __FILE__ == $0
  raise 'User ID should be the first and only argument!' if ARGV.size != 1

  user_id = ARGV[0].to_i
  p lambda_handler(event: { user_id: }.with_indifferent_access, context: {})
end
