class DesignPresenter < BasePresenter
  presents :design
  delegate :hours, :quoted?, to: :design

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_path, options
  end

  def edit_path
    h.edit_design_path(design)
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
    h.button_to 'Remove', h.design_path(design), method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, 
                class: 'secondary-action-button'
  end

  private

  def octicon_edit_content
    [ octicon('pencil'), time ].join(" ").html_safe
  end
end
