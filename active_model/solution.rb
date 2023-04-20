require 'csv'
require_relative 'customer'

class CustomerCSVUpload

  def self.call(file_name)
    new(file_name).call
  end
  private_class_method :new

  def initialize(file_name)
    @file_name = file_name
    @customers = []
  end

  def call
    @customers = mapped_customers
    raise 'CSV Upload failed! Fix errors before proceeding further!' if @customers.any? { |customer| !customer.valid? }

    puts 'CSV Upload successfull!'
  end

  private

  def mapped_customers
    mapped_rows = csv.readlines.map do |line|
      {
        'name' => line['Name'],
        'email' => line['Email'],
        'cardholder_name' => line['Cardholder Name'],
        'cardholder_email' => line['Cardholder Email'],
        'card_number' => line['Card Number']
      }
    end
    mapped_rows.map { |row| Customer.new(row) }
  end

  def csv
    file_io = File.open @file_name
    CSV.new file_io, headers: true
  end
end

if __FILE__ == $0
  CustomerCSVUpload.call('good_customers.csv')
  CustomerCSVUpload.call('bad_customers.csv')
end
