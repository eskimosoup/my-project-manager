class AccountManagementPriceCalculator

  attr_reader :hours, :rate

  def initialize(hours:, rate:)
    @hours = hours
    @rate = rate
  end

  def price
    (hours * rate).round(2)
  end
end
