require 'active_record'
require 'open-uri'

class User < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
