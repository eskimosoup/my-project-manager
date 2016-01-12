class AccountManagementPriceCalculator

  attr_reader :hours

  def initialize(hours:)
    @hours = hours
  end

  def price
    (hours * 65).round(2)
  end
end