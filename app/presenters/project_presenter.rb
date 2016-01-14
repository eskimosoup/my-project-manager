class ProjectPresenter < BasePresenter
  presents :project
  delegate :name, :brand_price, :brand_rush_job_price, to: :project

  def link
    project
  end

  def description
    h.simple_format project.description
  end

  def download_pdf_link(content = 'Download PDF')
    h.link_to content, h.project_downloads_path(project, format: 'pdf'),
              target: '_blank', class: 'action-button download'
  end

  def new_print_job_link(content = 'Add Print Item')
    h.link_to content, h.new_project_print_job_path(project),
              class: 'action-button'
  end

  def status
    project.status.humanize
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

  def brand_rush_job_price_currency
    h.number_to_currency brand_rush_job_price
  end
end
