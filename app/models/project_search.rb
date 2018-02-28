class ProjectSearch
  include ActiveModel::Model
  include ActiveAttr::QueryAttributes

  attribute :name, type: String
  Project.statuses.keys.map(&:to_sym).each do |status|
    attribute status
  end
  attribute :customer_id
  attribute :quote_stage_id
  attribute :brand_id
  attribute :per_page

  attribute :order_type
  attribute :order_by

  def initialize(attrs = {})
    @per_page = attrs.fetch(:per_page, 25)
    super(attrs)
  end

  def results
    @results ||= find_projects
  end

  def per_page_options
    [10, 15, 25, 50, 100]
  end

  def order
    "#{order_by} #{order_type}"
  end

  private

  def find_projects
    Project.name_search(name)
           .project_type(statuses_to_search)
           .customer_id(customer_id)
           .brand_id(brand_id)
           .quote_stage_id(quote_stage_id)
           .order(order_method)
  end

  def order_method
    case order
      when 'updated_at desc'
        "updated_at desc"
      when 'updated_at asc'
        "updated_at asc"

      when 'created_at desc'
        "created_at desc"
      when 'created_at asc'
        "created_at asc"

      when 'completed_at desc'
        "completed_at desc"
      when 'completed_at asc'
        "completed_at asc"

      when 'finalised_at asc'
        "finalised_at asc"
      when 'finalised_at desc'
        "finalised_at desc"
      else
        "completed_at asc"
    end
  end

  def statuses_to_search
    statuses = []
    Project.statuses.each do |status_name, integer|
      statuses << integer if send("#{status_name}?")
    end
    statuses
  end
end
