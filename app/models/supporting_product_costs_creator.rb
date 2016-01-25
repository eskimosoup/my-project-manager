class SupportingProductCostsCreator
  attr_reader :all_supporting_product_items, :print_job_id

  def initialize(print_job_id, all_supporting_product_items)
    @print_job_id = print_job_id
    @all_supporting_product_items = all_supporting_product_items
  end

  def grouped_supporting_product_items
    all_supporting_product_items.group_by(&:supporting_product_id).map do |supporting_product_id, supporting_product_items|
      {
        supporting_product_id: supporting_product_id,
        print_job_id: print_job_id,
        cost: sum_cost(supporting_product_items),
        area: sum_area(supporting_product_items)
      }
    end
  end

  def create_supporting_product_costs!
    grouped_supporting_product_items.each do |product_cost_hash|
      SupportingProductCost.create!(product_cost_hash)
    end
  end

  private

  def sum_cost(items)
    items.map(&:cost).reduce(0, :+)
  end
  
  def sum_area(items)
    items.map(&:area).reduce(0, :+)
  end
end
