require 'tty-prompt'

prompt = TTY::Prompt.new

prompt.yes?("Do you like Ruby?")

value = prompt.select("Choose core extentions for the class", %w( Array String Numeric Hash))

case value
when 'Array'
  puts "you selected Array"
when 'Numeric'
  puts "you selected Numeric"
end
