class DesignPresenter < BasePresenter
  presents :design
  delegate :hours, to: :design

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_design_path(design)
  end

  def time
    h.pluralize(hours, "hour")
  end

  def delete_link
    h.button_to 'Remove', design, method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, class: 'secondary-action-button'
  end
end
