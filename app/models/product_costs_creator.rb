class ProductCostsCreator

  attr_reader :all_product_items, :print_job_id

  def initialize(print_job_id, all_product_items)
    @print_job_id = print_job_id
    @all_product_items = all_product_items
  end

  def grouped_product_items
    all_product_items.group_by(&:product_id).map do |product_id, product_items|
      {
        product_id: product_id,
        print_job_id: print_job_id,
        variable_cost: sum_variable_cost(product_items),
        fixed_cost: sum_fixed_cost(product_items),
        area: sum_area(product_items)
      }
    end
  end

  def create_product_costs!
    grouped_product_items.each do |product_cost_hash|
      ProductCost.create!(product_cost_hash)
    end
  end

  private

  def sum_variable_cost(items)
    items.map(&:variable_cost).reduce(0, :+)
  end
  
  def sum_fixed_cost(items)
    items.map(&:fixed_cost).reduce(0, :+)
  end

  def sum_area(items)
    items.map(&:area).reduce(0, :+)
  end
end
