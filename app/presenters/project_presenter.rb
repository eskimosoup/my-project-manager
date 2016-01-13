class ProjectPresenter < BasePresenter
  presents :project
  delegate :name, to: :project

  def link
    project
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
end
