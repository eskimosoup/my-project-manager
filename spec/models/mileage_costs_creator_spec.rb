require "rails_helper"

describe MileageCostsCreator, type: :model do
  it "#grouped_mileages" do
    mileages = [
      instance_double("mileage", print_job_id: 1, miles: 2.40, cost: 8.50),
      instance_double("mileage", print_job_id: 1, miles: 3.60, cost: 16.50),
    ]

    cost_creator = MileageCostsCreator.new(1, mileages)

    expect(cost_creator.grouped_mileages).to eq({ print_job_id: 1, miles: 6.00, cost: 25.00 })
  end

  it "#create_mileage_cost" do
    print_job = create(:print_job)
    cost_hash = { print_job_id: print_job.id, miles: 4.53, cost: 8.97 }
    cost_creator = MileageCostsCreator.new(print_job.id, [])
    allow(cost_creator).to receive(:grouped_mileages).and_return(cost_hash)

    cost_creator.create_mileage_cost!

    expect(cost_creator).to have_received(:grouped_mileages)
    mileage_cost = MileageCost.last
    expect(mileage_cost.miles).to eq(4.53.to_d)
    expect(mileage_cost.cost).to eq(8.97.to_d)
    expect(mileage_cost.print_job_id).to eq(print_job.id)
  end
end
