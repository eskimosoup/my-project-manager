require "administrate/base_dashboard"

class BrandDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    telephone: Field::String,
    email: Field::String,
    website: Field::String,
    terms_conditions_link: Field::String,
    brand_type: EnumField,
    display: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :display,
    :created_at,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :telephone,
    :email,
    :website,
    :terms_conditions_link,
    :brand_type,
    :display,
  ]

  # Overwrite this method to customize how brands are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(brand)
  #   "Brand ##{brand.id}"
  # end
  def display_resource(brand)
    brand.name
  end
end
