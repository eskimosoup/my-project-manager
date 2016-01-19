require "rails_helper"

describe ProjectPriceCalculator, type: :model do
  it "#price" do
    print_jobs = [
      instance_double("print_job", price: 5.55),
      instance_double("print_job", price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.price).to eq(15.57)
  end

  it "#rush_job_price" do
    print_jobs = [
      instance_double("print_job", rush_job_price: 5.55),
      instance_double("print_job", rush_job_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.rush_job_price).to eq(15.57)
  end

  it "#trade_price" do
    print_jobs = [
      instance_double("print_job", trade_price: 5.55),
      instance_double("print_job", trade_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.trade_price).to eq(15.57)
  end

  it "#trade_rush_job_price" do
    print_jobs = [
      instance_double("print_job", trade_rush_job_price: 5.55),
      instance_double("print_job", trade_rush_job_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.trade_rush_job_price).to eq(15.57)
  end

  it "#my_price" do
    print_jobs = [
      instance_double("print_job", my_price: 5.55),
      instance_double("print_job", my_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.my_price).to eq(15.57)
  end

  it "#my_rush_job_price" do
    print_jobs = [
      instance_double("print_job", my_rush_job_price: 5.55),
      instance_double("print_job", my_rush_job_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.my_rush_job_price).to eq(15.57)
  end

  it "#my_customer_price" do
    print_jobs = [
      instance_double("print_job", my_customer_price: 5.55),
      instance_double("print_job", my_customer_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.my_customer_price).to eq(15.57)
  end

  it "#my_customer_rush_job_price" do
    print_jobs = [
      instance_double("print_job", my_customer_rush_job_price: 5.55),
      instance_double("print_job", my_customer_rush_job_price: 10.02)
    ]
    calc = ProjectPriceCalculator.new(print_jobs: print_jobs)

    expect(calc.my_customer_rush_job_price).to eq(15.57)
  end

end
