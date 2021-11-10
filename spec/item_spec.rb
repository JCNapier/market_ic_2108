require 'rspec'
require './lib/item'

describe Item do 
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

  it 'exists' do
    expect(item1).to be_an_instance_of(Item)
  end

  it 'attributes' do
    expect(item2.name).to eq("Tomato")
  end
end