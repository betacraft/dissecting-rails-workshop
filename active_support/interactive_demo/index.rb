require 'tty-prompt'
require 'active_support/all'

# Define some sample data
fruits = ['apple', 'banana', 'orange', 'kiwi']
numbers = [1, 2, 3, 4, 5]
string = "hello world"
date = Date.today
time = Time.now
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
hash = { "a" => 1, "b" => 2, "c" => 3 }
camelcase_string = "hello_world"
underscore_string = "HelloWorld"
bool = false
int = 42

# Use TTY prompt to get user input
prompt = TTY::Prompt.new
input = prompt.ask('Enter some text: ')

# Use ActiveSupport core extensions to manipulate input
puts "Input in all caps: #{input.upcase}"
puts "Input reversed: #{input.reverse}"
puts "Input truncated to 5 characters: #{input.truncate(5)}"

# Use ActiveSupport core extensions to manipulate array
puts "Fruits sorted alphabetically: #{fruits.sort}"
puts "Fruits as a sentence: #{fruits.to_sentence}"
puts "Array rotated by 2 positions: #{array.rotate(2)}"

# Use TTY prompt to get user multiple selection from array
selected_numbers = prompt.multi_select('Select some numbers (use space key):', numbers)
puts "Selected numbers: #{selected_numbers}"

# Use ActiveSupport core extensions to manipulate numbers
puts "Sum of selected numbers: #{selected_numbers.sum}"
puts "#{selected_numbers.sum} as a binary string: #{selected_numbers.sum.to_s(2)}"

# Use TTY prompt to get user input for date and time
selected_date = prompt.ask('Enter a date (YYYY-MM-DD): ')
selected_time = prompt.ask('Enter a time (HH:MM:SS): ')

# Use ActiveSupport core extensions to manipulate dates and times
parsed_date = Date.parse(selected_date)
parsed_time = Time.parse(selected_time)
puts "Selected date + 1 day: #{parsed_date.tomorrow}"
puts "Selected time in UTC: #{parsed_time.utc}"

# Use TTY prompt to get user input for a hash
selected_key = prompt.ask('Enter a hash key: ')
selected_value = prompt.ask('Enter a hash value: ')

# Use ActiveSupport core extensions to manipulate hashes
hash[selected_key] = selected_value
puts "Hash with new key-value pair: #{hash}"
puts "Hash as a string: #{hash.to_s}"
puts "Hash keys as an array: #{hash.keys}"

# Use ActiveSupport core extensions to manipulate strings
puts "String as camelcase: #{camelcase_string.camelize}"
puts "String as underscore: #{underscore_string.underscore}"
puts "String as a parameter: #{underscore_string.parameterize}"

# Use ActiveSupport core extensions to manipulate arrays
puts "Array as a set: #{array.to_set}"
puts "Array as a string: #{array.to_s}"
puts "Array without duplicates: #{array.uniq}"

# Use ActiveSupport core extensions to manipulate numbers
puts 'Absolute value of -42: #{(-42).abs}'
puts '42 as a Roman numeral: #{int.to_roman}'
puts '42 as a ordinal: #{int.ordinal}'

# Use ActiveSupport core extensions to manipulate arrays
puts "Array flattened: #{[[1, 2], [3, 4], [5, 6]].flatten}"
puts "Array sliced from index 2 to 4: #{array.slice(2, 3)}"
puts "Array without the first 3 elements: #{array.drop(3)}"

# Use ActiveSupport core extensions to manipulate strings
# Use TTY prompt to get user selection from array
selected_fruit = prompt.select('Select a fruit:', fruits)
puts "Selected fruit: #{selected_fruit}"
puts "String pluralized: #{selected_fruit.pluralize}"
puts "String singularized: #{'apples'.singularize}"

# Use ActiveSupport core extensions to manipulate dates
puts "Date as a formatted string: #{date.to_formatted_s(:long)}"
puts "Date at the end of the month: #{date.end_of_month}"
puts "Date in the next month: #{date.next_month}"
