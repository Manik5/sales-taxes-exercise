# require_relative "../exercise/input"

# describe "input" do

#   it "should turn the input file into an array" do
#     items = Input.new("../inputs/cart1.txt")
#     items.input_file.class.should == Array
#   end

#   it "should create a hash with the item name, quantity, and price, exceptions, imported" do
#     items = Input.new("../inputs/cart1.txt")
#     items_check = [ { name: "book", quantity: 1, price: 12.49, sales: false, imported: false, total: 12.49 },
#                     { name: "music CD", quantity: 1, price: 14.99, sales: true, imported: false, total: 14.99 },
#                     { name: "chocolate bar", quantity: 1, price: 0.85, sales: false, imported: false, total: 0.85 }
#                   ]
#     items.parsing.should == items_check
#   end

# end
