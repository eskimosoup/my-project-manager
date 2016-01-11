describe ProductItemTotalCalculator do
  it "#product_items_cost" do
    product_items = [
      instance_double("product_item", cost: 5.60.to_d),
      instance_double("product_item", cost: 4.54.to_d)
    ]
    calc = ProductItemTotalCalculator.new(product_items: product_items)

    expect(calc.cost).to eq(10.14)
  end

  it "#product_items_fixed_cost" do
    product_items = [
      instance_double("product_item", fixed_cost: 5.60.to_d),
      instance_double("product_item", fixed_cost: 4.54.to_d)
    ]
    calc = ProductItemTotalCalculator.new(product_items: product_items)

    expect(calc.fixed_cost).to eq(10.14)
  end

  it "#product_items_variable_cost" do
    product_items = [
      instance_double("product_item", variable_cost: 5.60.to_d),
      instance_double("product_item", variable_cost: 4.54.to_d)
    ]
    calc = ProductItemTotalCalculator.new(product_items: product_items)

    expect(calc.variable_cost).to eq(10.14)
  end

  it "#product_items_price" do
    product_items = [
      instance_double("product_item", price: 5.60.to_d),
      instance_double("product_item", price: 4.54.to_d)
    ]
    calc = ProductItemTotalCalculator.new(product_items: product_items)

    expect(calc.price).to eq(10.14)
  end
end
