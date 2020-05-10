require './exercise/input'
require './exercise/calculate'
require './exercise/display'

class Run

  def initialize(namefile)
    @namefile = namefile
  end

  def input
    file = Input.new(@namefile)
    file.parsing
    file
  end

  def calculation
    costs = Calculate.new(input.items)
    costs.total
    costs
  end

  def display
    Display.review(input.input_file, @namefile)
    bill = Display.new(calculation.items, calculation.total_taxes, calculation.total_price)
    bill.show
  end


  def terminal
    puts "\n"
    puts "*" * 31
    puts "*" + " " * 29 + "*"
    puts "*   Welcome to the store!     *"
    puts "*" + " " * 29 + "*"
    puts "*" * 31
    puts "\n"
    puts "Adding your file...."
    sleep 2
    puts "\n"
    input
    calculation
    display
  end
end

namefile = ARGV.first
purchase = Run.new(namefile)
purchase.terminal
