#!/usr/bin/env ruby
require_relative 'config'
require_relative 'migrations/1_create_users_table'
require_relative 'models/user'
require 'csv'

CreateUsersTable.migrate :up

CSV.read('users.csv', headers: true).each do |row|
  User.create! name: "#{row['first_name']} #{row['last_name']}",
               email: row['email']
end
