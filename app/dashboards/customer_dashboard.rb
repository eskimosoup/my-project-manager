require "administrate/base_dashboard"

class CustomerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    # main_contact: Field::HasOne,
    addresses: Field::HasMany,
    contacts: Field::HasMany,
    projects: Field::HasMany,
    invoices: Field::HasMany.with_options(class_name: "::Invoice"),
    id: Field::Number,
    name: Field::String,
    credit_limit: Field::String.with_options(searchable: false),
    amount_on_credit: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    payment_days: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    #:main_contact,
    :addresses,
    :contacts,
    :projects,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :main_contact,
    :addresses,
    :contacts,
    :projects,
    :invoices,
    :id,
    :name,
    :credit_limit,
    :amount_on_credit,
    :created_at,
    :updated_at,
    :payment_days,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :main_contact,
    :addresses,
    :contacts,
    :projects,
    :invoices,
    :name,
    :credit_limit,
    :amount_on_credit,
    :payment_days,
  ].freeze

  # Overwrite this method to customize how customers are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(customer)
    customer.name
  end
end
