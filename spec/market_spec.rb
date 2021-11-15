require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

describe Market do 
  let(:market) {Market.new("South Pearl Street Farmers Market")}
  let(:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let(:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let(:vendor3) {Vendor.new("Palisade Peach Shack")}
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  it 'exists' do
    expect(market).to be_an_instance_of(Market)
  end

  it 'attributes' do
    expect(market.name).to eq("South Pearl Street Farmers Market")
    expect(market.vendors).to eq([])
  end

  context 'iteration 2' do 
    before(:each) do 
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    end
  
    it '#add vendor' do 
      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    end

    it '#vendor names' do 
      expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it '#vendors that sell' do 
      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
  end  

  context 'iteration 3' do 
    before(:each) do 
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      vendor3.stock(item3, 10)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
    end

    it '#items' do 
      expect(market.items).to eq([item1, item2, item4, item3])
    end

    it '#total_quanity_per_item' do 
      expect(market.total_quantity_per_item(item1) ).to eq(100)
    end

    it '#total inventory' do 
      expected = {
      item1 => {
        quantity: 100,
        vendors: [vendor1, vendor3]
      },
      item2 => {
        quantity: 7,
        vendors: [vendor1]
      },
      item4 => {
        quantity: 50,
        vendors: [vendor2]
      },
      item3 => {
        quantity: 35,
        vendors: [vendor2, vendor3]
      },
      }

      expect(market.total_inventory).to eq(expected)
    end

    it '#overstocked_items' do 
      expect(market.overstocked_items).to eq([item1])
    end
  end 
end