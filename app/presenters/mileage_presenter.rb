class MileagePresenter < BasePresenter
  presents :mileage
  delegate :miles, to: :mileage

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_mileage_path(mileage)
  end

  def mileage_text
    h.pluralize(miles, "mile")
  end

  def delete_link
    h.button_to 'Remove', mileage, method: :delete,
      data: { confirm: 'Are you sure?', disable_with: 'processing...' },
      class: 'secondary-action-button'
  end
end
