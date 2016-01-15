class ProductItemPresenter < BasePresenter
  presents :product_item
  delegate :name, :area, to: :product_item

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_product_item_path(product_item)
  end

  def delete_link
    h.button_to 'Remove', product_item, method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, class: 'secondary-action-button'
  end
end
