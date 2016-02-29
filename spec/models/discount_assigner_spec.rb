require "rails_helper"

describe DiscountAssigner, type: :model do
  it "#total_discount" do
    discounts = [
      instance_double("discount", amount: 5),
      instance_double("discount", amount: 5)
    ]
    da = DiscountAssigner.new(discounts: discounts, envisage_amount: 80, my_amount: 100, cost: 20)

    expect(da.total_discount).to eq(10)
  end

  it "#envisage_discount" do
    discounts = [
      instance_double("discount", amount: 5),
      instance_double("discount", amount: 5)
    ]
    da = DiscountAssigner.new(discounts: discounts, envisage_amount: 80, my_amount: 120, cost: 20)

    expect(da.envisage_discount).to eq(6)
  end

  it "#my_discount" do
    discounts = [
      instance_double("discount", amount: 5),
      instance_double("discount", amount: 5)
    ]
    da = DiscountAssigner.new(discounts: discounts, envisage_amount: 80, my_amount: 120, cost: 20)

    expect(da.my_discount).to eq(4)
  end
end
