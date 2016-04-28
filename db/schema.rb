# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160428081316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_managements", force: :cascade do |t|
    t.integer  "print_job_id",                          null: false
    t.decimal  "hours",        precision: 15, scale: 2, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "account_managements", ["print_job_id"], name: "index_account_managements_on_print_job_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.string   "line_1",      null: false
    t.string   "line_2"
    t.string   "line_3"
    t.string   "city",        null: false
    t.string   "postcode",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree

  create_table "brand_addresses", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "name"
    t.string   "line_1",     null: false
    t.string   "line_2"
    t.string   "line_3"
    t.string   "city",       null: false
    t.string   "postcode",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "brand_addresses", ["brand_id"], name: "index_brand_addresses_on_brand_id", unique: true, using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name",                                                           null: false
    t.boolean  "display",                                         default: true
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "brand_type",                                      default: 0,    null: false
    t.string   "telephone"
    t.string   "email"
    t.string   "website"
    t.string   "terms_conditions_link"
    t.decimal  "account_management_rate", precision: 6, scale: 2, default: 0.0,  null: false
  end

  add_index "brands", ["name"], name: "index_brands_on_name", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "customer_id",          null: false
    t.string   "forename",             null: false
    t.string   "email"
    t.string   "phone"
    t.string   "role"
    t.datetime "made_main_contact_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "surname"
  end

  add_index "contacts", ["customer_id"], name: "index_contacts_on_customer_id", using: :btree
  add_index "contacts", ["made_main_contact_at"], name: "index_contacts_on_made_main_contact_at", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.decimal  "credit_limit",     precision: 7, scale: 2, default: 0.0, null: false
    t.decimal  "amount_on_credit", precision: 7, scale: 2, default: 0.0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "customers", ["name"], name: "index_customers_on_name", unique: true, using: :btree

  create_table "designs", force: :cascade do |t|
    t.integer  "print_job_id",                          null: false
    t.decimal  "hours",        precision: 15, scale: 2, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "designs", ["print_job_id"], name: "index_designs_on_print_job_id", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.integer  "project_id",                           null: false
    t.string   "description",                          null: false
    t.decimal  "amount",      precision: 10, scale: 2, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "discounts", ["project_id"], name: "index_discounts_on_project_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "project_id",                                                null: false
    t.string   "slug"
    t.string   "name",                                                      null: false
    t.integer  "percentage",                                                null: false
    t.decimal  "amount",           precision: 10, scale: 2,                 null: false
    t.boolean  "paid",                                      default: false, null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "stripe_charge_id"
    t.decimal  "vat",              precision: 10, scale: 2
  end

  add_index "invoices", ["project_id"], name: "index_invoices_on_project_id", using: :btree
  add_index "invoices", ["slug"], name: "index_invoices_on_slug", unique: true, using: :btree
  add_index "invoices", ["stripe_charge_id"], name: "index_invoices_on_stripe_charge_id", using: :btree

  create_table "job_specifications", force: :cascade do |t|
    t.decimal  "hours",        precision: 15, scale: 2, null: false
    t.integer  "print_job_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "job_specifications", ["print_job_id"], name: "index_job_specifications_on_print_job_id", using: :btree

  create_table "labour_items", force: :cascade do |t|
    t.integer  "print_job_id",                          null: false
    t.integer  "labour_id",                             null: false
    t.decimal  "hours",        precision: 15, scale: 2, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "labour_items", ["labour_id"], name: "index_labour_items_on_labour_id", using: :btree
  add_index "labour_items", ["print_job_id"], name: "index_labour_items_on_print_job_id", using: :btree

  create_table "labours", force: :cascade do |t|
    t.string   "name",                                              null: false
    t.text     "description"
    t.decimal  "per_hour",    precision: 5, scale: 2,               null: false
    t.integer  "mark_up",                             default: 100, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "labours", ["name"], name: "index_labours_on_name", unique: true, using: :btree

  create_table "mileage_costs", force: :cascade do |t|
    t.decimal  "miles",        precision: 15, scale: 2, null: false
    t.decimal  "cost",         precision: 15, scale: 2, null: false
    t.integer  "print_job_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "mileage_costs", ["print_job_id"], name: "index_mileage_costs_on_print_job_id", using: :btree

  create_table "mileages", force: :cascade do |t|
    t.decimal  "miles",        precision: 15, scale: 2, null: false
    t.integer  "print_job_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "mileages", ["print_job_id"], name: "index_mileages_on_print_job_id", using: :btree

  create_table "my_print_services_items", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.decimal  "cost",         precision: 15, scale: 2, null: false
    t.integer  "print_job_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "my_print_services_items", ["print_job_id"], name: "index_my_print_services_items_on_print_job_id", using: :btree

  create_table "print_jobs", force: :cascade do |t|
    t.integer  "project_id"
    t.text     "name",                                                              null: false
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.decimal  "envisage_sale_price",       precision: 10, scale: 2
    t.decimal  "envisage_trade_sale_price", precision: 10, scale: 2
    t.decimal  "envisage_to_my_sale_price", precision: 10, scale: 2
    t.decimal  "my_sale_price",             precision: 10, scale: 2
    t.text     "description"
    t.boolean  "vat",                                                default: true, null: false
  end

  add_index "print_jobs", ["project_id", "name"], name: "index_print_jobs_on_project_id_and_name", unique: true, using: :btree
  add_index "print_jobs", ["project_id"], name: "index_print_jobs_on_project_id", using: :btree

  create_table "product_costs", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "print_job_id"
    t.decimal  "variable_cost", precision: 10, scale: 2, null: false
    t.decimal  "fixed_cost",    precision: 10, scale: 2, null: false
    t.decimal  "area",          precision: 15, scale: 3, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "product_costs", ["print_job_id"], name: "index_product_costs_on_print_job_id", using: :btree
  add_index "product_costs", ["product_id"], name: "index_product_costs_on_product_id", using: :btree

  create_table "product_items", force: :cascade do |t|
    t.decimal  "area",         precision: 15, scale: 3, null: false
    t.integer  "print_job_id",                          null: false
    t.integer  "product_id",                            null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "product_items", ["print_job_id"], name: "index_product_items_on_print_job_id", using: :btree
  add_index "product_items", ["product_id"], name: "index_product_items_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                                                 null: false
    t.text     "description"
    t.decimal  "substrate_cost", precision: 5, scale: 2,               null: false
    t.decimal  "hardware_cost",  precision: 5, scale: 2
    t.decimal  "ink_cost",       precision: 5, scale: 2
    t.decimal  "printer_cost",   precision: 5, scale: 2
    t.integer  "mark_up",                                default: 100, null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "products", ["name"], name: "index_products_on_name", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "brand_id"
    t.string   "name",                                null: false
    t.text     "description"
    t.integer  "status",              default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.boolean  "rush_job",            default: false
    t.string   "purchase_order"
    t.date     "delivery_deadline"
    t.text     "notes"
    t.integer  "contact_id"
  end

  add_index "projects", ["billing_address_id"], name: "index_projects_on_billing_address_id", using: :btree
  add_index "projects", ["brand_id"], name: "index_projects_on_brand_id", using: :btree
  add_index "projects", ["contact_id"], name: "index_projects_on_contact_id", using: :btree
  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["shipping_address_id"], name: "index_projects_on_shipping_address_id", using: :btree
  add_index "projects", ["status"], name: "completed", where: "(status = 2)", using: :btree
  add_index "projects", ["status"], name: "index_projects_on_status", using: :btree
  add_index "projects", ["status"], name: "quoted", where: "(status = 0)", using: :btree
  add_index "projects", ["status"], name: "sold", where: "(status = 1)", using: :btree

  create_table "sundry_costs", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.decimal  "cost",         precision: 15, scale: 2, null: false
    t.integer  "print_job_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "sundry_costs", ["print_job_id"], name: "index_sundry_costs_on_print_job_id", using: :btree

  create_table "sundry_items", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.decimal  "cost",         precision: 15, scale: 2, null: false
    t.integer  "print_job_id",                          null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "sundry_items", ["print_job_id"], name: "index_sundry_items_on_print_job_id", using: :btree

  create_table "supporting_product_costs", force: :cascade do |t|
    t.integer  "supporting_product_id"
    t.integer  "print_job_id"
    t.decimal  "cost",                  precision: 15, scale: 2, null: false
    t.decimal  "area",                  precision: 15, scale: 3, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "supporting_product_costs", ["print_job_id"], name: "index_supporting_product_costs_on_print_job_id", using: :btree
  add_index "supporting_product_costs", ["supporting_product_id"], name: "index_supporting_product_costs_on_supporting_product_id", using: :btree

  create_table "supporting_product_items", force: :cascade do |t|
    t.decimal  "area",                  precision: 15, scale: 3, null: false
    t.integer  "supporting_product_id",                          null: false
    t.integer  "print_job_id",                                   null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "supporting_product_items", ["print_job_id"], name: "index_supporting_product_items_on_print_job_id", using: :btree
  add_index "supporting_product_items", ["supporting_product_id"], name: "index_supporting_product_items_on_supporting_product_id", using: :btree

  create_table "supporting_products", force: :cascade do |t|
    t.string   "name",                                                 null: false
    t.text     "description"
    t.decimal  "substrate_cost", precision: 7, scale: 2,               null: false
    t.integer  "mark_up",                                default: 100, null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "supporting_products", ["name"], name: "index_supporting_products_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",                                          null: false
    t.boolean  "admin",                          default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "vehicle_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vehicle_types", ["name"], name: "index_vehicle_types_on_name", unique: true, using: :btree

  create_table "vehicle_wraps", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.text     "description",                                            null: false
    t.decimal  "envisage_override_price",       precision: 10, scale: 2
    t.decimal  "envisage_trade_override_price", precision: 10, scale: 2
    t.decimal  "envisage_to_my_override_price", precision: 10, scale: 2
    t.decimal  "my_override_price",             precision: 10, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "vehicle_type_id"
  end

  add_index "vehicle_wraps", ["vehicle_type_id"], name: "index_vehicle_wraps_on_vehicle_type_id", using: :btree

  create_table "vehicle_wraps_account_managements", force: :cascade do |t|
    t.decimal  "hours",           precision: 15, scale: 2, null: false
    t.integer  "vehicle_wrap_id",                          null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_account_managements", ["vehicle_wrap_id"], name: "index_vehicle_wraps_account_managements_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_designs", force: :cascade do |t|
    t.decimal  "hours",           precision: 15, scale: 2, null: false
    t.integer  "vehicle_wrap_id",                          null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_designs", ["vehicle_wrap_id"], name: "index_vehicle_wraps_designs_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_job_specifications", force: :cascade do |t|
    t.decimal  "hours",           precision: 15, scale: 2, null: false
    t.integer  "vehicle_wrap_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_job_specifications", ["vehicle_wrap_id"], name: "index_vehicle_wraps_job_specifications_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_labours", force: :cascade do |t|
    t.decimal  "hours",           precision: 15, scale: 2, null: false
    t.integer  "vehicle_wrap_id"
    t.integer  "labour_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_labours", ["labour_id"], name: "index_vehicle_wraps_labours_on_labour_id", using: :btree
  add_index "vehicle_wraps_labours", ["vehicle_wrap_id"], name: "index_vehicle_wraps_labours_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_materials", force: :cascade do |t|
    t.decimal  "area",            precision: 15, scale: 3, null: false
    t.integer  "vehicle_wrap_id"
    t.integer  "product_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_materials", ["product_id"], name: "index_vehicle_wraps_materials_on_product_id", using: :btree
  add_index "vehicle_wraps_materials", ["vehicle_wrap_id"], name: "index_vehicle_wraps_materials_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_mileages", force: :cascade do |t|
    t.decimal  "miles",           precision: 15, scale: 2, null: false
    t.integer  "vehicle_wrap_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_mileages", ["vehicle_wrap_id"], name: "index_vehicle_wraps_mileages_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_sundry_items", force: :cascade do |t|
    t.decimal  "cost",            precision: 15, scale: 2, null: false
    t.integer  "vehicle_wrap_id"
    t.string   "name",                                     null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "vehicle_wraps_sundry_items", ["vehicle_wrap_id"], name: "index_vehicle_wraps_sundry_items_on_vehicle_wrap_id", using: :btree

  create_table "vehicle_wraps_supporting_materials", force: :cascade do |t|
    t.decimal  "area",                  precision: 15, scale: 3, null: false
    t.integer  "vehicle_wrap_id"
    t.integer  "supporting_product_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "vehicle_wraps_supporting_materials", ["supporting_product_id"], name: "supporting_product_supporting_materials", using: :btree
  add_index "vehicle_wraps_supporting_materials", ["vehicle_wrap_id"], name: "vehicle_wrap_supporting materials", using: :btree

  add_foreign_key "account_managements", "print_jobs", on_delete: :cascade
  add_foreign_key "addresses", "customers", on_delete: :cascade
  add_foreign_key "brand_addresses", "brands", on_delete: :cascade
  add_foreign_key "contacts", "customers", on_delete: :cascade
  add_foreign_key "designs", "print_jobs", on_delete: :cascade
  add_foreign_key "discounts", "projects", on_delete: :cascade
  add_foreign_key "invoices", "projects", on_delete: :cascade
  add_foreign_key "job_specifications", "print_jobs", on_delete: :cascade
  add_foreign_key "labour_items", "labours", on_delete: :cascade
  add_foreign_key "labour_items", "print_jobs", on_delete: :cascade
  add_foreign_key "mileage_costs", "print_jobs", on_delete: :cascade
  add_foreign_key "mileages", "print_jobs", on_delete: :cascade
  add_foreign_key "my_print_services_items", "print_jobs", on_delete: :cascade
  add_foreign_key "print_jobs", "projects", on_delete: :cascade
  add_foreign_key "product_costs", "print_jobs", on_delete: :cascade
  add_foreign_key "product_costs", "products", on_delete: :cascade
  add_foreign_key "product_items", "print_jobs", on_delete: :cascade
  add_foreign_key "product_items", "products", on_delete: :cascade
  add_foreign_key "projects", "addresses", column: "billing_address_id", on_delete: :cascade
  add_foreign_key "projects", "addresses", column: "shipping_address_id", on_delete: :cascade
  add_foreign_key "projects", "brands", on_delete: :cascade
  add_foreign_key "projects", "contacts"
  add_foreign_key "projects", "customers", on_delete: :cascade
  add_foreign_key "sundry_costs", "print_jobs", on_delete: :cascade
  add_foreign_key "sundry_items", "print_jobs", on_delete: :cascade
  add_foreign_key "supporting_product_costs", "print_jobs", on_delete: :cascade
  add_foreign_key "supporting_product_costs", "supporting_products", on_delete: :cascade
  add_foreign_key "supporting_product_items", "print_jobs", on_delete: :cascade
  add_foreign_key "supporting_product_items", "supporting_products", on_delete: :cascade
  add_foreign_key "vehicle_wraps", "vehicle_types", on_delete: :cascade
  add_foreign_key "vehicle_wraps_account_managements", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_designs", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_job_specifications", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_labours", "labours"
  add_foreign_key "vehicle_wraps_labours", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_materials", "products"
  add_foreign_key "vehicle_wraps_materials", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_mileages", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_sundry_items", "vehicle_wraps", on_delete: :cascade
  add_foreign_key "vehicle_wraps_supporting_materials", "supporting_products"
  add_foreign_key "vehicle_wraps_supporting_materials", "vehicle_wraps", on_delete: :cascade
end
