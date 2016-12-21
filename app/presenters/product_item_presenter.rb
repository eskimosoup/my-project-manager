class ProductItemPresenter < BasePresenter
  presents :product_item
  delegate :name, :area, :quoted?, to: :product_item

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_path, options
  end

  def edit_path
    h.edit_product_item_path(product_item)
  end

  def octicon_edit_link
    # if quoted?
    edit_link_content(edit_octicon_content, class: 'product-item-link')
    # else
    #  description
    # end
  end

  def delete_link
    return nil unless quoted?
    h.button_to 'Remove', h.product_item_path(product_item), method: :delete,
                                                             data: { confirm: 'Are you sure?', disable_with: 'processing...' },
                                                             class: 'secondary-action-button'
  end

  private

  def edit_octicon_content
    [octicon('pencil'), description].join(' ').html_safe
  end

  def description
    [name, format_area(area)].join(' ').html_safe
  end
end
