class LabourItemPresenter < BasePresenter
  presents :labour_item
  delegate :hours, :name, to: :labour_item

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_labour_item_path(labour_item)
  end

  def time
    h.pluralize(hours, "hour")
  end

  def delete_link
    h.button_to 'Remove', labour_item, method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, class: 'secondary-action-button'
  end
end
