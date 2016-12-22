class SundryItemPresenter < BasePresenter
  presents :sundry_item
  delegate :name, :cost, :quoted?, to: :sundry_item

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_path, options
  end

  def edit_path
    h.edit_sundry_item_path(sundry_item)
  end

  def cost_currency
    h.number_to_currency cost
  end

  def octicon_edit_link
    # if quoted?
    edit_link_content(edit_octicon_content, class: 'basic-listing-link')
    # else
    #  description
    # end
  end

  def delete_link
    return nil unless quoted?
    h.button_to 'Remove', h.sundry_item_path(sundry_item), method: :delete,
                                                           data: { confirm: 'Are you sure?', disable_with: 'processing...' },
                                                           class: 'secondary-action-button'
  end

  def description
    [name, cost_currency].join(' ').html_safe
  end

  private

  def edit_octicon_content
    [octicon('pencil'), description].join(' ').html_safe
  end
end
