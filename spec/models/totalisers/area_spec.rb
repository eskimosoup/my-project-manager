require "rails_helper"

describe Totalisers::Area, type: :model do
  it "#name" do
    totaliser = Totalisers::Area.new(name: "Product Name", items: [])

    expect(totaliser.name).to eq("Product Name")
  end

  it "#price" do
    products = [
      instance_double("product", envisage_price: 2.91),
      instance_double("product", envisage_price: 1.17)
    ]
    totaliser = Totalisers::Area.new(name: "", items: products)

    expect(totaliser.price).to eq(4.08)
  end

  it "#cost" do
    products = [
      instance_double("product", envisage_price: 2.50),
      instance_double("product", envisage_price: 1.17)
    ]
    totaliser = Totalisers::Area.new(name: "", items: products)

    expect(totaliser.price).to eq(3.67)
  end

  it "#units" do
    products = [
      instance_double("product", area: 5),
      instance_double("product", area: 5)
    ]
    totaliser = Totalisers::Area.new(name: "", items: products)

    expect(totaliser.units).to eq("10 sqm")
  end
end
