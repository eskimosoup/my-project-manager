require "administrate/base_dashboard"

class ProjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    quote_stage: Field::BelongsTo,
    brand: Field::BelongsTo,
    customer: Field::BelongsTo,
    shipping_address: Field::BelongsTo.with_options(class_name: "Address"),
    billing_address: Field::BelongsTo.with_options(class_name: "Address"),
    business_address: Field::HasOne,
    main_contact: Field::HasOne,
    account_managements: Field::HasMany,
    designs: Field::HasMany,
    discounts: Field::HasMany,
    invoices: Field::HasMany.with_options(class_name: "::Invoice"),
    paid_invoices: Field::HasMany.with_options(class_name: "Project"),
    envisage_invoices: Field::HasMany.with_options(class_name: "Envisage::Invoice"),
    percentage_invoices: Field::HasMany.with_options(class_name: "::PercentageInvoice"),
    amount_invoices: Field::HasMany.with_options(class_name: "::AmountInvoice"),
    job_specifications: Field::HasMany,
    labour_items: Field::HasMany,
    mileages: Field::HasMany,
    print_jobs: Field::HasMany,
    product_items: Field::HasMany,
    sundry_items: Field::HasMany,
    supporting_product_items: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    status: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    shipping_address_id: Field::Number,
    billing_address_id: Field::Number,
    rush_job: Field::Boolean,
    purchase_order: Field::String,
    delivery_deadline: Field::DateTime,
    notes: Field::Text,
    contact_id: Field::Number,
    finalised_at: Field::DateTime,
    completed_at: Field::DateTime,
    quote_stage_updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :quote_stage,
    :brand,
    :customer,
    :shipping_address,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :quote_stage,
    :brand,
    :customer,
    :shipping_address,
    :billing_address,
    :main_contact,
    :account_managements,
    :designs,
    :discounts,
    :invoices,
    :paid_invoices,
    :envisage_invoices,
    :percentage_invoices,
    :amount_invoices,
    :job_specifications,
    :labour_items,
    :mileages,
    :print_jobs,
    :product_items,
    :sundry_items,
    :supporting_product_items,
    :id,
    :name,
    :description,
    :status,
    :created_at,
    :updated_at,
    :shipping_address_id,
    :billing_address_id,
    :rush_job,
    :purchase_order,
    :delivery_deadline,
    :notes,
    :contact_id,
    :finalised_at,
    :completed_at,
    :quote_stage_updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :quote_stage,
    :brand,
    :customer,
    :shipping_address,
    :billing_address,
    :main_contact,
    :account_managements,
    :designs,
    :discounts,
    :invoices,
    :paid_invoices,
    :envisage_invoices,
    :percentage_invoices,
    :amount_invoices,
    :job_specifications,
    :labour_items,
    :mileages,
    :print_jobs,
    :product_items,
    :sundry_items,
    :supporting_product_items,
    :name,
    :description,
    :status,
    :shipping_address_id,
    :billing_address_id,
    :rush_job,
    :purchase_order,
    :delivery_deadline,
    :notes,
    :contact_id,
    :finalised_at,
    :completed_at,
    :quote_stage_updated_at,
  ].freeze

  # Overwrite this method to customize how projects are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(project)
    project.name
  end
end
