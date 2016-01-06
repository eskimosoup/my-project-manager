class PrintJobPriceCalculator
  attr_reader :print_job
  delegate :job_specifications, :labour_items, :product_items,
    :sundry_items, :supporting_product_items, to: :print_job

  def initialize(print_job:)
    @print_job = print_job
  end
end
