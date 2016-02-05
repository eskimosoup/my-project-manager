class AccountManagementPriceCalculator

  attr_reader :hours

  def initialize(hours:)
    @hours = hours
  end

  def price
    (hours * 30).round(2)
  end
end
