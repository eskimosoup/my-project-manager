class ProjectSearch
  include ActiveModel::Model
  include ActiveAttr::TypecastedAttributes

  attribute :name, type: String
  Project.statuses.keys.map(&:to_sym).each do |status|
    attribute status, type: Boolean
  end
  attribute :customer_id, type: Integer
  attribute :brand_id, type: Integer
  attribute :per_page, type: Integer

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

  private

  def find_projects
    Project.name_search(name).project_type(statuses_to_search).
      customer_id(customer_id).brand_id(brand_id)
  end

  def statuses_to_search
    statuses = []
    Project.statuses.each do |status_name, integer|
      statuses << integer if send("#{ status_name }?")
    end
    statuses
  end

  
  Project.statuses.keys.each do |status|
    define_method "#{ status }?" do
      send(status)
    end
  end
end
