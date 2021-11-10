class Vendor
  attr_reader :name, 
              :inventory 

  def initialize(name)
    @name      = name 
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    if @inventory.keys.include?(item)
      @inventory[item] += quantity
    elsif !@inventory.keys.include?(item)
      @inventory[item] = quantity
    end 
  end

  def potential_revenue
    revenue = 0
    @inventory.each_pair do |k, v|
      revenue += ((k.price.delete("$").to_f) * v)
    end
    revenue
  end
end