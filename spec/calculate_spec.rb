require_relative '../exercise/calculate.rb'

describe "calculate" do
  it "should add the sale tax to the item total" do
    items = [ { name: "music CD", qty: 1, price: 14.99, sale: true, import: false, total: 14.99 } ]
    bill = Calculate.new(items)
    bill.apply_sales_tax
    bill.items[0][:total].should == 16.49
  end

  it "should total sales tax" do
    items = [ { name: "book", qty: 1, price: 12.49, sale: false, import: false, total: 12.49},
              { name: "music CD", qty: 1, price: 14.99, sale: true, import: false, total: 14.99 },
              { name: "chocolate bar", qty: 1, price: 0.85, sale: false, import: false, total: 0.85 }
            ]
    bill = Calculate.new(items)
    bill.apply_sales_tax.should == 1.5
  end

  it "should add the imported tax to the item total" do
    items = [ { name: "imported bottle of chocolates", qty: 1, price: 10.00, sale: false, import: true, total: 10.00 } ]
    bill = Calculate.new(items)
    bill.apply_imported_tax
    bill.items[0][:total].should == 10.50
  end

  it "should total imported tax" do
    items = [ { name: "imported bottle of chocolates", qty: 1, price: 10.00, sale: false, import: true, total: 10.00 },
              { name: "imported bottle of perfume", qty: 1, price: 47.50, sale: true, import: true, total: 47.50 }
            ]
    bill = Calculate.new(items)
    bill.apply_imported_tax.should == 2.90
  end

  it "should total the sales and imported tax" do
    items = [ { name: "imported bottle of chocolates", qty: 1, price: 10.00, sale: false, import: true, total: 10.00 },
              { name: "imported bottle of perfume", qty: 1, price: 47.50, sale: true, import: true, total: 47.50 }
            ]
    bill = Calculate.new(items)
    bill.sales_tax.should == 7.65

    items2 = [ { name: "book", qty: 1, price: 12.49, sale: false, import: false, total: 12.49},
              { name: "music CD", qty: 1, price: 14.99, sale: true, import: false, total: 14.99 },
              { name: "chocolate bar", qty: 1, price: 0.85, sale: false, import: false, total: 0.85 }
            ]
    bill2 = Calculate.new(items2)
    bill2.sales_tax.should == 1.50
  end

  it "should take the default price of the items and sum them" do
    items = [ { name: "imported bottle of chocolates", qty: 1, price: 10.00, sale: false, import: true, total: 10.50 },
              { name: "imported bottle of perfume", qty: 1, price: 47.50, sale: true, import: true, total: 54.65 }
            ]
    bill = Calculate.new(items)
    bill.pick_price.should == [10.00, 47.50]
    bill.sum_price.should == 57.50
  end

  it "should sum the default price of the items and total tax" do
    items = [ { name: "imported bottle of chocolates", qty: 1, price: 10.00, sale: false, import: true, total: 10.00 },
              { name: "imported bottle of perfume", qty: 1, price: 47.50, sale: true, import: true, total: 47.50 }
            ]
    bill = Calculate.new(items)
    bill.total.should == 65.15
  end

end
