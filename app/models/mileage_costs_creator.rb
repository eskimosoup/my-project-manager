class MileageCostsCreator
  attr_reader :all_mileages, :print_job_id

  def initialize(print_job_id, all_mileages)
    @print_job_id = print_job_id
    @all_mileages = all_mileages
  end

  def grouped_mileages
    {
      print_job_id: print_job_id,
      miles: sum_miles,
      cost: sum_costs
    }
  end

  def create_mileage_cost!
    MileageCost.create!(grouped_mileages)
  end

  private

  def sum_miles
    all_mileages.map(&:miles).reduce(0, :+)
  end

  def sum_costs
    all_mileages.map(&:cost).reduce(0, :+)
  end

end
