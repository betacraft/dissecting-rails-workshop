#!/usr/bin/env ruby

require 'csv'
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

  def to_s
    "#<User @first_name=#{first_name.inspect} @last_name=#{last_name.inspect} @email=#{email.inspect}>"
  end
end

# Validate a CSV file with first_name, last_name and email headers
# going over each row at a time.
# This class will also let you know which rows have invalid data
# and what needs to be fixed.
class UserCSVValidator

  def self.call(file_name)
    new(file_name).call
  end
  private_class_method :new

  def initialize(file_name)
    @file_name = file_name
    @users = []
    @invalid_users = []
  end

  def call
    @users = mapped_users
    @invalid_users = scan_invalid_users
    unless @invalid_users.size.positive?
      puts "#{@file_name} is valid!"
      return @users
    end

    puts "Invalid rows found in CSV #{@file_name}!"
    @invalid_users.each do |index, invalid_user|
      puts "Row: #{index} | #{invalid_user} | #{invalid_user.errors.full_messages.to_sentence}"
    end
  end

  private

  def mapped_users
    csv.readlines.map do |line|
      User.new first_name: line['first_name'],
               last_name: line['last_name'],
               email: line['email']
    end
  end

  def csv
    file_io = File.open @file_name
    CSV.new file_io, headers: true
  end

  def scan_invalid_users
    @users.map.with_index { |user, index| [index, user] }
          .reject { |_index, user| user.valid? }
  end
end

UserCSVValidator.call('misc/good_users.csv')
UserCSVValidator.call('misc/bad_users.csv')
