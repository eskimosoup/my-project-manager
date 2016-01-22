class SundryItemPresenter < BasePresenter
  presents :sundry_item
  delegate :name, :cost, to: :sundry_item

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_sundry_item_path(sundry_item)
  end

  def cost_currency
    h.number_to_currency cost
  end

  def delete_link
    h.button_to 'Remove', sundry_item, method: :delete,
      data: { confirm: 'Are you sure?', disable_with: 'processing...' },
      class: 'secondary-action-button'
  end
end
