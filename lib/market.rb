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
    end.flatten.uniq
  end

  def quantity_hash(item) 

  end

  def item_hash 
    item_array.reduce({}) do |hash, item|
      hash[item] = {}
      hash
    end
  end

  def total_inventory

  end
end