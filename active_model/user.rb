require 'active_model'
require 'open-uri'

class User
  include ActiveModel::API

  attr_accessor :first_name, :last_name, :email

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def initialize(attributes = {})
    super
    @errors = ActiveModel::Errors.new(self)
  end

  def to_s
    "#<User @first_name=#{first_name.inspect} @last_name=#{last_name.inspect} @email=#{email.inspect}>"
  end
end
