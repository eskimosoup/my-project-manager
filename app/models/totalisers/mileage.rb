class Totalisers::Mileage

  def initialize(mileages:)
    @mileages = mileages
  end

  def name
    "Mileage"
  end

  def price
    @price ||= mileages.map(&:price).reduce(0, :+)
  end

  def cost
    @cost ||= mileages.map(&:cost).reduce(0, :+)
  end

  def units
    "#{ total_miles } miles"
  end

  private

  attr_reader :mileages

  def total_miles
    @miles ||= mileages.map(&:miles).reduce(0, :+)
  end
end
