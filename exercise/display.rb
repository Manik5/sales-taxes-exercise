class Display

  def initialize(items, total_taxes, total_price)
    @items = items
    @taxes = total_taxes
    @price = total_price
  end

  def set_decimals(item)
    item = "%.2f" % item
    item
  end

  def  display_item(item)
    item[:total] = set_decimals(item[:total])
    puts "#{item[:quantity] } #{item[:name] } #{item[:total]}"
  end

  def display_taxes
    @taxes = set_decimals(@taxes)
    puts "Sales Taxes: #{@taxes}"
  end

  def display_price
    @price = set_decimals(@price)
    puts "Total: #{@price}"
  end

  def show
     puts "--------------------------------"
    puts "\n"
    puts "Here is the bill: "
    puts "\n"
    puts "\n"
     @items.each do |item|
      display_item(item)
     end
     display_taxes
     display_price
  end

  def self.review(input, namefile)
    puts "-------------------------------------"
    puts "\n"
    puts "You bought #{namefile}, which includes:"
    puts "\n"
    puts input
    puts "\n"
  end
end
