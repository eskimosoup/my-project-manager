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
    Project.name_search(name)
           .project_type(statuses_to_search)
           .customer_id(customer_id)
           .brand_id(brand_id)
           .quote_stage_id(quote_stage_id)
           .order(updated_at: :desc)
  end

  def statuses_to_search
    statuses = []
    Project.statuses.each do |status_name, integer|
      statuses << integer if send("#{status_name}?")
    end
    statuses
  end
end
