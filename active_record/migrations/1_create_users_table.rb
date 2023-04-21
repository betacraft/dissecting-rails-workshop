require 'active_record'

class CreateUsersTable < ActiveRecord::Migration[7.0]

  def change
    create_table :users, if_not_exists: true do |table|
      table.string :name
      table.string :email
      table.timestamps
    end

    add_index :users, :email, unique: true
  end
end
