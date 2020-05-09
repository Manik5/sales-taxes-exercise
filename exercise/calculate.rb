# The problem it's here, because on the check type method
# it doesn't give back an array of hashes
# so the tax of 1.5 can't be applied because it doesn't see the items
# don't know how to fix

require 'pry'
class Calculate

	attr_accessor :items, :total_taxes, :total_price

	def initialize(input_items)
		@items = input_items
		@sales_tax = 0.10
		@imported_tax = 0.05
		@sum_sales_tax = 0.0
		@sum_imported_tax = 0.0
		@total_taxes = 0.0
		@total_price = 0.0
		@round_cent = 1 / 0.05
	end

	def check_type(type)
		products = @items.filter { |item| item[type] == true }
		products # it doesn't print out the array and this is the problem
	end


	def check_tax(applied_tax)
		apply_tax = ((applied_tax * @round_cent).ceil / @round_cent)
		apply_tax
	end

	# adding the tax, multiplying the price, quantity and tax
	def add_tax(price, quantity, tax)
		tax_to_add = (price * quantity *tax)
		new_tax = check_tax(tax_to_add)
		new_tax
	end

	def sum_total(total, tax)
		total += tax
		total = total.round(2)
		total
	end

	# sales taxes 10% ----> 0.10

	def total_sales_tax(products)
		products.each do | product |
			tax_to_add = add_tax(product[:price], product[:quantity], @sales_tax)
			product[:total] = sum_total(product[:total], tax_to_add)
			@sum_sales_tax += tax_to_add
		end
	end

	def apply_sales_tax
		products = check_type(:product)
		total_sales_tax(products)
		@sum_sales_tax
	end

	# imported taxes 5% ----> 0.05
	def total_imported_tax(products)
		products.each do | product |
			tax_to_add = add_tax(product[:price], product[:quantity] , @imported_tax)
			product[:total] = sum_total(product[:total], tax_to_add)
			@sum_imported_tax += tax_to_add
		end
	end

		def apply_imported_tax
			products = @items.select { |item| item[:imported] == true}
			sum_up = total_imported_tax(products)
			@sum_imported_tax
		end

		# total

		def sum_taxes(sale, import)
			tax_to_add = sale.to_f + import.to_f
			tax_to_add
		end

		def sales_tax
			@total_taxes = sum_taxes(apply_sales_tax, apply_imported_tax)
			@total_taxes
		end

		def pick_price
			default_price = @items.map { |item| item[:price] }.flatten
			default_price
		end

		def sum_price
			total_price = pick_price.inject(:+)
			total_price
		end

		def total
			@total_price = sum_price + sales_tax
			@total_price
		end
end
