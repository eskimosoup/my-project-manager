require "administrate/base_dashboard"

class PercentageInvoiceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    project: Field::BelongsTo,
    customer: Field::HasOne,
    brand: Field::HasOne,
    id: Field::Number,
    slug: Field::String,
    name: Field::String,
    percentage: Field::Number,
    amount: Field::String.with_options(searchable: false),
    paid: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    stripe_charge_id: Field::String,
    vat: Field::String.with_options(searchable: false),
    due_date: Field::DateTime,
    type: Field::String,
    vat_items_description: Field::Text,
    vat_items_total: Field::String.with_options(searchable: false),
    non_vat_items_description: Field::Text,
    non_vat_items_total: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :project,
    :customer,
    :brand,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :project,
    :customer,
    :brand,
    :id,
    :slug,
    :name,
    :percentage,
    :amount,
    :paid,
    :created_at,
    :updated_at,
    :stripe_charge_id,
    :vat,
    :due_date,
    :type,
    :vat_items_description,
    :vat_items_total,
    :non_vat_items_description,
    :non_vat_items_total,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :project,
    :customer,
    :brand,
    :name,
    :percentage,
    :amount,
    :paid,
    :vat,
    :due_date,
    :vat_items_description,
    :vat_items_total,
    :non_vat_items_description,
    :non_vat_items_total,
    :created_at
  ].freeze

  # Overwrite this method to customize how percentage invoices are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(percentage_invoice)
  #   "PercentageInvoice ##{percentage_invoice.id}"
  # end
end
