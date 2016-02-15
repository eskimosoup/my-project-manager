class ProjectPriceCalculator
  attr_reader :print_jobs

  def initialize(print_jobs:)
    @print_jobs = print_jobs
  end

  def brand_price
    sum_array(:brand_price)
  end

  def envisage_to_my_price
    sum_array(:envisage_to_my_price)
  end

  private

  def sum_array(attr)
    print_jobs.map(&attr).reduce(:+)
  end
end
