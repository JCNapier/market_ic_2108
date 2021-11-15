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
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def item_array 
    @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten
  end

  def items 
   item_array.uniq
  end

  def total_quantity_per_item(item) 
    @vendors.map do |vendor|
      vendor.inventory[item]
    end.sum
  end

  def total_inventory
    items.reduce({}) do |hash, item|
      hash[item] = {} if !hash[item].is_a?(Hash)
      hash[item][:quantity] = total_quantity_per_item(item) 
      hash[item][:vendors]  = vendors_that_sell(item)
      hash
    end
  end

  def overstocked_items
    items.find_all do |item|
      total_quantity_per_item(item) > 50 && 
      item_array.count {|obj| obj == item} > 1
    end
  end
end