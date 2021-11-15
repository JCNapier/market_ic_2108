class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name    = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
      # vendor.inventory.keys.include?(item)
    end
  end

  def total_inventory
    market_totals = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        market_totals[item] ||= {quantity: 0, vendors: []}
        market_totals[item][:quantity] += quantity
        market_totals[item][:vendors] << vendor
      end
    end
  end

  def overstocked_items
    #make list of all items sold => [{name => 'Peach', quantity => 35}]
    #find items that are sold by more 1 or more vendors
    #find total quantity of those items
    items = []
    @vendors.each do |vendor|
      require "pry"; binding.pry
       items << vendor.inventory
    end
  end
end

#
# {
#   @name="Peach", @price="$0.75" =>35,
#   @name="Tomato", @price="$0.50" =>7
# }




# def total_inventory
#   market_totals = {}
#   @vendors.each do |vendor|
#     vendor.inventory.each do |item, quantity|
#       market_totals[item] ||= {quantity: 0, vendors: []}
#       market_totals[item][:quantity] += quantity
#       market_totals[item][:vendors] << vendor
#     end
#   end
#   market_totals




# describe Market do
#   it 'exists' do
#     market = Market.new("South Pearl Street Farmers Market")

#     expect(market).to be_an_instance_of(Market)
#   end

#   it 'has attributes' do
#     market = Market.new("South Pearl Street Farmers Market")

#     expect(market.name).to eq("South Pearl Street Farmers Market")
#     expect(market.vendors).to eq([])
#   end

#   it 'can stock/track items for venders and add venders' do
#     market = Market.new("South Pearl Street Farmers Market")

#     vendor1 = Vendor.new("Rocky Mountain Fresh")

#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: "$0.50"})
#     item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#     item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

#     vendor1.stock(item1, 35)
#     vendor1.stock(item2, 7)

#     vendor2 = Vendor.new("Ba-Nom-a-Nom")
#     vendor2.stock(item4, 50)
#     vendor2.stock(item3, 25)

#     vendor3 = Vendor.new("Palisade Peach Shack")
#     vendor3.stock(item1, 65)
#     vendor3.stock(item3, 0)

#     market.add_vendor(vendor1)
#     market.add_vendor(vendor2)
#     market.add_vendor(vendor3)

#     expect(market.vendors).to eq([vendor1, vendor2, vendor3])
#     expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
#     expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
#     expect(market.vendors_that_sell(item4)).to eq([vendor2])
#     expect(market.vendors_that_sell(item3)).to eq([vendor2])
#   end

#   it '#total_inventory' do
#     market = Market.new("South Pearl Street Farmers Market")

#     vendor1 = Vendor.new("Rocky Mountain Fresh")

#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: "$0.50"})
#     item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#     item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

#     vendor1.stock(item1, 35)
#     vendor1.stock(item2, 7)

#     vendor2 = Vendor.new("Ba-Nom-a-Nom")
#     vendor2.stock(item4, 50)
#     vendor2.stock(item3, 25)

#     vendor3 = Vendor.new("Palisade Peach Shack")
#     vendor3.stock(item1, 65)
#     vendor3.stock(item3, 10)

#     market.add_vendor(vendor1)
#     market.add_vendor(vendor2)
#     market.add_vendor(vendor3)

#     expected = {
#       item1 => {
#         quantity: 100,
#         vendors: [vendor1, vendor3]
#       },
#       item2 => {
#         quantity: 7,
#         vendors: [vendor1]
#       },
#       item4 => {
#         quantity: 50,
#         vendors: [vendor2]
#       },
#       item3 => {
#         quantity: 35,
#         vendors: [vendor2, vendor3]
#       },
#     }

#     expect(market.total_inventory).to eq(expected)
#   end

#   it '#overstocked items' do
#     market = Market.new("South Pearl Street Farmers Market")

#     vendor1 = Vendor.new("Rocky Mountain Fresh")

#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: "$0.50"})
#     item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#     item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

#     vendor1.stock(item1, 35)
#     vendor1.stock(item2, 7)

#     vendor2 = Vendor.new("Ba-Nom-a-Nom")
#     vendor2.stock(item4, 50)
#     vendor2.stock(item3, 25)

#     vendor3 = Vendor.new("Palisade Peach Shack")
#     vendor3.stock(item1, 65)
#     vendor3.stock(item3, 10)

#     market.add_vendor(vendor1)
#     market.add_vendor(vendor2)
#     market.add_vendor(vendor3)

#     expect(market.overstocked_items).to eq([item1])
#   end
# end


# describe Vendor do
#   it 'exists' do
#     vendor = Vendor.new("Rocky Mountain Fresh")

#     expect(vendor).to be_an_instance_of(Vendor)
#   end

#   it 'has attributes' do
#     vendor = Vendor.new("Rocky Mountain Fresh")
#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: '$0.50'})

#     expect(vendor.name).to eq("Rocky Mountain Fresh")
#     expect(vendor.inventory).to eq({})
#     expect(vendor.check_stock(item1)).to eq(0)
#   end

#   it 'can check current stock, and add items to stock' do
#     vendor = Vendor.new("Rocky Mountain Fresh")
#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: '$0.50'})

#     expect(vendor.check_stock(item1)).to eq(0)

#     vendor.stock(item1, 30)

#     expect(vendor.inventory).to eq({item1 => 30})
#     expect(vendor.check_stock(item1)).to eq(30)

#     vendor.stock(item1, 25)
#     expect(vendor.check_stock(item1)).to eq(55)

#     vendor.stock(item2, 12)
#     expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
#   end

#   it 'can calculate potential revenue' do
#     market = Market.new("South Pearl Street Farmers Market")

#     vendor1 = Vendor.new("Rocky Mountain Fresh")

#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: "$0.50"})
#     item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#     item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

#     vendor1.stock(item1, 35)
#     vendor1.stock(item2, 7)

#     vendor2 = Vendor.new("Ba-Nom-a-Nom")
#     vendor2.stock(item4, 50)
#     vendor2.stock(item3, 25)

#     vendor3 = Vendor.new("Palisade Peach Shack")
#     vendor3.stock(item1, 65)
#     vendor3.stock(item3, 0)

#     market.add_vendor(vendor1)
#     market.add_vendor(vendor2)
#     market.add_vendor(vendor3)

#     expect(vendor1.potential_revenue).to eq(29.75)
#     expect(vendor2.potential_revenue).to eq(345.00)
#     expect(vendor3.potential_revenue).to eq(48.75)
#   end
# end

# class Vendor
#   attr_reader :name,
#               :inventory

#   def initialize(name)
#     @name      = name
#     @inventory = {}
#   end

#   def check_stock(item)
#     if @inventory[item]
#   end

#   def stock(item, quantity)
#     @inventory[item] += quantity
#   end

#   def potential_revenue
#     @inventory.sum do | item, quantity |
#       item.price * quantity
#     end
#   end
# end

# class Item
#   attr_reader :name

#   def initialize(info)
#     @name  = info[:name]
#     @price = info[:price]
#   end

#   def price
#     @price.delete("$").to_f
#   end
# end




# describe Item do
#   it 'exists' do
#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: '$0.50'})

#     expect(item1).to be_an_instance_of(Item)
#     expect(item2).to be_an_instance_of(Item)
#   end
#   it 'has attributes' do
#     item1 = Item.new({name: 'Peach', price: "$0.75"})
#     item2 = Item.new({name: 'Tomato', price: '$0.50'})

#     expect(item2.name).to eq("Tomato")
#     expect(item2.price).to eq(0.5)
#   end
# end
