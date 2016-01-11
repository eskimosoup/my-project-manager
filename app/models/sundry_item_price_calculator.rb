class SundryItemPriceCalculator

  attr_reader :sundry_item
  delegate :cost, to: :sundry_item

  def initialize(sundry_item:)
    @sundry_item = sundry_item
  end

  def decimal_mark_up
    1.2.to_d
  end

  def price
    (decimal_mark_up * cost).round(2)
  end
end
