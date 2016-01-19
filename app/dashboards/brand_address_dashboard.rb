require "administrate/base_dashboard"

class BrandAddressDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    brand: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    line_1: Field::String,
    line_2: Field::String,
    line_3: Field::String,
    city: Field::String,
    postcode: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :brand,
    :id,
    :name,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :brand,
    :name,
    :line_1,
    :line_2,
    :line_3,
    :city,
    :postcode,
  ]

  # Overwrite this method to customize how addresses are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(address)
  #   "Address ##{address.id}"
  # end
end
