require 'rails_helper'

describe Item do
  it "is valid with title, description, rate, category and location" do
    item = Item.new(
      title: 'Digger',
      description: 'This is a digger',
      rate: 40,
      category_id: 1,
      location_id: 1)
    expect(item).to be_valid
  end

  it "is invalid without title" do
    item = Item.new(
      title: '',
      description: 'This is a digger',
      rate: 40,
      category_id: 1,
      location_id: 1)
    expect(item).not_to be_valid
    expect(item.errors[:title]).to include("can't be blank")
  end

  it "is invalid without description" do
    item = Item.new(
      title: 'Digger',
      description: '',
      rate: 40,
      category_id: 1,
      location_id: 1)
    expect(item).not_to be_valid
    expect(item.errors[:description]).to include("can't be blank")
  end

  it "is invalid without rate" do
    item = Item.new(
      title: 'Digger',
      description: 'This is a digger',
      rate: nil,
      category_id: 1,
      location_id: 1)
    expect(item).not_to be_valid
    expect(item.errors[:rate]).to include("can't be blank")
  end

  it "is invalid without category" do
    item = Item.new(
      title: 'Digger',
      description: 'This is a digger',
      rate: 40,
      category_id: nil,
      location_id: 1)
    expect(item).not_to be_valid
    expect(item.errors[:category_id]).to include("can't be blank")
  end

  it "is invalid without location" do
    item = Item.new(
      title: 'Digger',
      description: 'This is a digger',
      rate: 40,
      category_id: 1,
      location_id: nil)
    expect(item).not_to be_valid
    expect(item.errors[:location_id]).to include("can't be blank")
  end

  it "returns an item's address and location as a string" do
    item = Item.create(
      title: 'Digger',
      description: 'This is a digger',
      rate: 40,
      category_id: 1,
      location_id: 1,
      user_id: 1,
      address: '1 Colombo Street')
    #FIGURE OUT TEST BELOW
    # expect(item.full_address).to eq '1 Colombo Street, Christchurch, New Zealand'
  end
end
