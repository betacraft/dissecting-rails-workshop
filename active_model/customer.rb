require 'active_model'

class Customer

  include ActiveModel::API

  attr_accessor :name, :email, :cardholder_name, :cardholder_email, :card_number

  validates :name, :email, :cardholder_name, :cardholder_email, :card_number, presence: true

  def initialize(attributes = {})
    super
    @errors = ActiveModel::Errors.new(self)
  end
end
