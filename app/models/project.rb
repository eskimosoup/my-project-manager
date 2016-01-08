class Project < ActiveRecord::Base

  belongs_to :brand
  belongs_to :customer  
  has_many :print_jobs
  
  enum status: %w( quoted sold completed )

  validates :brand, presence: true
  validates :customer, presence: true
  validates :name, presence: true
  
  delegate :price, :rush_job_price, :trade_price, :trade_rush_job_price,
    :my_price, :my_rush_job_price, :my_customer_price, :my_customer_rush_job_price,
    to: :price_calculator

  def price_calculator
    @price_calculator ||= ProjectPriceCalculator.new(print_jobs: print_jobs)
  end
end
