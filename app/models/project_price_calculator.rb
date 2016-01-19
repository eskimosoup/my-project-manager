class ProjectPriceCalculator
  attr_reader :print_jobs

  def initialize(print_jobs:)
    @print_jobs = print_jobs
  end

  def price
    sum_array(:price)
  end

  def rush_job_price
    sum_array(:rush_job_price)
  end

  def trade_price
    sum_array(:trade_price)
  end
  
  def trade_rush_job_price
    sum_array(:trade_rush_job_price)
  end

  def my_price
    sum_array(:my_price)
  end

  def my_rush_job_price
    sum_array(:my_rush_job_price)
  end

  def my_customer_price
    sum_array(:my_customer_price)
  end

  def my_customer_rush_job_price
    sum_array(:my_customer_rush_job_price)
  end

  private

  def sum_array(attr)
    print_jobs.map(&attr).reduce(:+)
  end
end
