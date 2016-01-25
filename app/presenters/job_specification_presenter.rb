class JobSpecificationPresenter < BasePresenter
  presents :job_specification
  delegate :hours, :quoted?, to: :job_specification

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_path, options
  end

  def edit_path
    h.edit_job_specification_path(job_specification)
  end

  def time
    h.pluralize(hours, "hour")
  end

  def octicon_edit_link
    if quoted?
      edit_link_content(octicon_edit_content, class: 'basic-listing-link')
    else
      time
    end
  end

  def delete_link
    return nil unless quoted?
    h.button_to 'Remove', h.job_specification_path(job_specification), method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' },
                class: 'secondary-action-button'
  end

  private

  def octicon_edit_content
    [ octicon('pencil'), time ].join(" ").html_safe
  end
end
