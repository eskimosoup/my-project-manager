class LabourPriceCalculator

  attr_reader :labour, :hours
  delegate :per_hour, :mark_up, to: :labour

  def initialize(labour:, hours:)
    @labour = labour
    @hours = hours
  end

  def decimal_mark_up
    mark_up.to_d / 100
  end

  def total_cost
    (hours.to_d * per_hour).round(2)
  end

  def price
    (decimal_mark_up * total_cost).round(2)
  end
end
