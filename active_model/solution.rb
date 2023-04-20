#!/usr/bin/env ruby

require 'csv'
require_relative 'user'

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
    return unless @invalid_users.size.positive?

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

if __FILE__ == $0
  UserCSVValidator.call('good_users.csv')
  UserCSVValidator.call('bad_users.csv')
end
