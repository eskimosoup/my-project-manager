class Totalisers::Area
  attr_reader :name

  def initialize(name:, items:)
    @name = name
    @items = items
  end

  def price
    @price ||= items.map(&:envisage_price).reduce(0, :+)
  end

  def cost
    @cost ||= items.map(&:cost).reduce(0, :+)
  end

  def units
    "#{ total_area } sqm"
  end

  private

  attr_reader :items

  def total_area
    @total_area ||= items.map(&:area).reduce(0, :+)
  end
end
