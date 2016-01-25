require "rails_helper"

describe ProductCostsCreator, type: :model do
  it "#grouped_product_items" do
    product_items = [ 
      instance_double("product_item", product_id: 1, print_job_id: 1, 
                      variable_cost: 1.57, fixed_cost: 2.03, area: 2.00),
      instance_double("product_item", product_id: 1, print_job_id: 1, 
                      variable_cost: 2.43, fixed_cost: 1.25, area: 2.00),
      instance_double("product_item", product_id: 2, print_job_id: 1, 
                      variable_cost: 2.07, fixed_cost: 0.50, area: 5.00)
    ]

    cost_creator = ProductCostsCreator.new(1, product_items)

    expect(cost_creator.grouped_product_items).to eq([
      { product_id: 1, print_job_id: 1, variable_cost: 4.00, fixed_cost: 3.28, area: 4.00 },
      { product_id: 2, print_job_id: 1, variable_cost: 2.07, fixed_cost: 0.50, area: 5.00 },
    ])
  end

  it "#create_product_costs!" do
    product = create(:product)
    print_job = create(:print_job)
    cost_hash = { product_id: product.id, print_job_id: print_job.id,
                  variable_cost: 4.00, fixed_cost: 3.28, area: 5.25 }
    cost_creator = ProductCostsCreator.new(print_job.id, [])
    allow(cost_creator).to receive(:grouped_product_items).and_return([cost_hash])

    cost_creator.create_product_costs!

    expect(cost_creator).to have_received(:grouped_product_items)
    product_cost = ProductCost.last
    expect(product_cost.variable_cost).to eq(4.00)
    expect(product_cost.fixed_cost).to eq(3.28)
    expect(product_cost.area).to eq(5.25)
  end
end
