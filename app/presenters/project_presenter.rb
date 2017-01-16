class ProjectPresenter < BasePresenter
  presents :project
  delegate :name, :brand_price, :brand_rush_job_price, :brand_profit, :envisage_profit_without_labour, :profit, to: :project

  def reference_number
    "#{project.customer_id}-#{project.id + 100}"
  end

  def brand_name
    project.brand.name
  end

  def link
    project
  end

  def description
    h.simple_format project.description
  end

  def delivery_deadline
    return 'No deadline' unless project.delivery_deadline
    h.l project.delivery_deadline
  end

  def notes
    h.simple_format project.notes
  end

  def download_pdf_link(content = 'Download PDF')
    h.link_to content, h.project_downloads_path(project, format: 'pdf'),
              target: '_blank', class: 'secondary-action-button download'
  end

  def new_print_job_link(content = 'Add Print Item')
    h.link_to content, h.new_project_print_job_path(project),
              class: 'action-button'
  end

  def status
    project_status.humanize
  end

  def print_jobs_count
    project.print_jobs.size
  end

  def linked_content(content = project.name)
    h.link_to content, link
  end

  def customer_name
    project.customer.name
  end

  def brand_price_currency
    h.number_to_currency brand_price
  end

  def profit_currency
    h.number_to_currency profit
  end

  def brand_profit_currency
    return '' unless project.brand_profit
    h.number_to_currency project.brand_profit
  end

  def envisage_price_currency
    return '' unless project.envisage_to_my_price
    h.number_to_currency project.envisage_to_my_price
  end

  def envisage_profit_currency
    return '' unless project.envisage_profit
    h.number_to_currency project.envisage_profit
  end

  def job_type
    if rush_job?
      'Rush Job'
    else
      'Standard'
    end
  end

  def mark_sold
    return nil unless project.quoted?
    h.button_to 'Mark As Sold', h.project_seller_path(project), method: :post,
                                                                data: { disable_with: 'Processing...' }, class: 'secondary-action-button'
  end

  def mark_finalised
    return nil unless project.sold?
    h.link_to 'Finalise Project', h.new_project_finaliser_path(project),
              data: { disable_with: 'Processing...' }, class: 'secondary-action-button'
  end

  def envisage_job_sheet_link(content = 'Download Envisage Job Sheet', options = {})
    h.link_to content, h.project_envisage_job_sheet_path(project, format: 'pdf'), options
  end

  def my_job_sheet_link(content = 'Download My Job Sheet', options = {})
    h.link_to content, h.project_my_job_sheet_path(project, format: 'pdf'), options
  end

  def add_vehicle_wrap_link
    return nil unless project.vehicle_brand? && project.quoted?
    h.link_to 'Add Vehicle Wrap', h.project_vehicle_wraps_path(project), class: 'action-button'
  end

  private

  def project_status
    @project_status ||= project.status
  end

  def rush_job?
    project.rush_job?
  end
end
