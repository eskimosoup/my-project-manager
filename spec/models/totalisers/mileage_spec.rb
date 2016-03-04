require "rails_helper"

describe Totalisers::Mileage, type: :model do
  it "#units" do
    mileages = [
      instance_double("mileage", miles: 5),
      instance_double("mileage", miles: 5)
    ]
    totaliser = Totalisers::Mileage.new(mileages: mileages)

    expect(totaliser.units).to eq("10 miles")
  end

  it "#price" do
    mileages = [
      instance_double("mileage", price: 5.25),
      instance_double("mileage", price: 5.25)
    ]
    totaliser = Totalisers::Mileage.new(mileages: mileages)

    expect(totaliser.price).to eq(10.50)
  end

  it "#cost" do
    mileages = [
      instance_double("mileage", cost: 5.25),
      instance_double("mileage", cost: 5.25)
    ]
    totaliser = Totalisers::Mileage.new(mileages: mileages)

    expect(totaliser.cost).to eq(10.50)
    totaliser = Totalisers::Mileage.new(mileages: [])
    expect(totaliser.cost).to eq(0)
  end

  it "#name" do
    totaliser = Totalisers::Mileage.new(mileages: [])
    expect(totaliser.name).to eq("Mileage")
  end

end
