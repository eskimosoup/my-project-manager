class MileagePresenter < BasePresenter
  presents :mileage
  delegate :miles, :quoted?, to: :mileage

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_path, options
  end

  def edit_path
    h.edit_mileage_path(mileage)
  end

  def octicon_edit_link
    # if quoted?
    edit_link_content(edit_octicon_content, class: 'basic-listing-link')
    # else
    #  mileage_text
    # end
  end

  def mileage_text
    h.pluralize(miles, 'mile')
  end

  def delete_link
    return nil unless quoted?
    h.button_to 'Remove', h.mileage_path(mileage), method: :delete,
                                                   data: { confirm: 'Are you sure?', disable_with: 'processing...' },
                                                   class: 'secondary-action-button'
  end

  private

  def edit_octicon_content
    [octicon('pencil'), mileage_text].join(' ').html_safe
  end
end
