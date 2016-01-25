require "rails_helper"

describe SupportingProductCostsCreator, type: :model do
  it "#grouped_supporting_product_items" do
    product_items = [ 
      instance_double("supporting_product_item", supporting_product_id: 1, print_job: 1, 
                      cost: 1.57, area: 2.00),
      instance_double("supporting_product_item", supporting_product_id: 1, print_job: 1, 
                      cost: 2.43, area: 2.00),
      instance_double("supporting_product_item", supporting_product_id: 2, print_job: 1, 
                      cost: 2.07, area: 5.00)
    ]

    cost_creator = SupportingProductCostsCreator.new(1, product_items)

    expect(cost_creator.grouped_supporting_product_items). to eq([
      { supporting_product_id: 1, print_job_id: 1, cost: 4.00, area: 4.00 },
      { supporting_product_id: 2, print_job_id: 1, cost: 2.07, area: 5.00 },
    ])
  end

  it "#create_supporting_product_costs!" do
    supporting_product = create(:supporting_product)
    print_job = create(:print_job)
    cost_hash = { supporting_product_id: supporting_product.id, print_job_id: print_job.id,
                  cost: 4.00, area: 5.25 }
    cost_creator = SupportingProductCostsCreator.new(print_job.id, [])
    allow(cost_creator).to receive(:grouped_supporting_product_items).and_return([cost_hash])

    cost_creator.create_supporting_product_costs!

    expect(cost_creator).to have_received(:grouped_supporting_product_items)
    supporting_product_cost = SupportingProductCost.last
    expect(supporting_product_cost.cost).to eq(4.00)
    expect(supporting_product_cost.area).to eq(5.25)
  end
end
