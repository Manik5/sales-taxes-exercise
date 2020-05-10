require 'pry'

class Input
  attr_accessor :input_file, :items


  def initialize(folder)
    @input_file = File.open(File.dirname(File.dirname(__FILE__)) + '/inputs/' + folder).to_a
    @exceptions = set_exceptions(File.dirname(File.dirname(__FILE__)) + '/exceptions.txt')
    @items = []
  end

  def set_exceptions(folder)
    exceptions = File.open(folder).to_a
    exceptions.map! { |item| item.chomp }
     exceptions # good
  end

  def parsing
    @input_file.each do |item|
      item= item.strip.split(/\s/)
      check(item)
    end
  end

  def check(item)
    add_item = {
      quantity: check_quantity(item),
      name: check_name(item),
      price: check_price(item),
      sales: verify_sales(item),
      imported: verify_imported(item),
      total: calculate_total(item)
    }
    @items << add_item
    @items
  end

  def check_quantity(item)
    item[0].to_i
  end

  def check_name(item)
    last_element = (item.index "at") - 1
    pick = item[1..last_element] * " "
    pick
  end

  def check_price(item)
    first_element = (item.index "at") + 1
    last_element = item.size
    pick = item[first_element..last_element]
    pick[0].to_f
  end

  def verify_sales(item)
    crosscheck = item & @exceptions
    crosscheck = crosscheck * " "
    crosscheck != "" ? false : true
  end

  def verify_imported(item)
    verify_import = item.include? "imported"
    verify_import == true ? true : false
  end

  def calculate_total(item)
    total = check_quantity(item) * check_price(item)
    total
  end
end

