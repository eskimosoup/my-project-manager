class JobSpecificationPresenter < BasePresenter
  presents :job_specification
  delegate :hours, to: :job_specification

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_job_specification_path(job_specification)
  end

  def time
    h.pluralize(hours, "hour")
  end

  def delete_link
    h.button_to 'Remove', job_specification, method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, class: 'secondary-action-button'
  end
end
