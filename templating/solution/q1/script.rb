require 'erb'

Food     = Struct.new(:name, :price)
template = ERB.new(File.read("#{__dir__}/template.erb"))

input = nil
@foods = []
File.open("solution1.html", "w"){ |f| f.write template.result(binding)}

while(input != "q")
	print "Enter -> Food name: "
	bname = gets.chomp
	print "Enter -> Price: "
	price = gets.chomp
	@foods << Food.new(bname, price)
	File.open("solution1.html", "w"){ |f| f.write template.result(binding)}
	print "Menu updated\n"

	print "Enter any key to add more food items and q to exit: "
	input = gets.chomp
end