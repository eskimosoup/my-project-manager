class LabourItemPresenter < BasePresenter
  presents :labour_item
  delegate :hours, :name, :quoted?, to: :labour_item

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_path, options
  end

  def edit_path
    h.edit_labour_item_path(labour_item)
  end

  def time
    h.pluralize(hours, "hour")
  end

  def octicon_edit_link
    if quoted?
      edit_link_content(octicon_edit_content, class: 'basic-listing-link')
    else
      description
    end
  end

  def delete_link
    return nil unless quoted?
    h.button_to 'Remove', h.labour_item_path(labour_item), method: :delete,
      data: { confirm: 'Are you sure?', disable_with: 'processing...' }, 
      class: 'secondary-action-button'
  end

  private

  def octicon_edit_content
    [ octicon('pencil'), description ].join(' ').html_safe
  end

  def description
    [ name, time ].join(" ")
  end
end
