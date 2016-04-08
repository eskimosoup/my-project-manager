class PriceCalculator::VehicleWrap
  attr_reader :vehicle_wrap
  delegate :job_specifications, to: :vehicle_wrap
  delegate :labours, to: :vehicle_wrap
  delegate :mileages, to: :vehicle_wrap
  delegate :materials, to: :vehicle_wrap
  delegate :sundry_items, to: :vehicle_wrap
  delegate :supporting_materials, to: :vehicle_wrap
  delegate :account_managements, to: :vehicle_wrap
  delegate :designs, to: :vehicle_wrap

  def initialize(vehicle_wrap:)
    @vehicle_wrap = vehicle_wrap
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
    [account_managements, designs, job_specifications, labours, mileages, materials, sundry_items, supporting_materials].flatten
  end
  
end
