class SupportingProductItemPresenter < BasePresenter
  presents :supporting_product
  delegate :name, :area, to: :supporting_product

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_supporting_product_item_path(supporting_product)
  end

  def delete_link
    h.button_to 'Remove', supporting_product, method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, class: 'secondary-action-button'
  end
end
