class PriceCalculator::PrintJob
  attr_reader :print_job

  delegate :account_managements, to: :print_job
  delegate :designs, to: :print_job
  delegate :job_specifications, to: :print_job
  delegate :labour_items, to: :print_job
  delegate :mileages, to: :print_job
  delegate :product_items, to: :print_job
  delegate :sundry_items, to: :print_job
  delegate :supporting_product_items, to: :print_job

  def initialize(print_job:)
    @print_job = print_job
  end

  def cost
    items.map(&:cost).reduce(0, :+)
  end

  def envisage_price
    items.map(&:envisage_price).reduce(0, :+)
  end

  def envisage_trade_price
    items.map(&:envisage_trade_price).reduce(0, :+)
  end

  def envisage_to_my_price
    items.map(&:envisage_to_my_price).reduce(0, :+)
  end

  def my_price
    items.map(&:my_price).reduce(0, :+)
  end

  private

  def items
    [account_managements, designs, job_specifications, labour_items, mileages, product_items, sundry_items, supporting_product_items].flatten
  end
end
