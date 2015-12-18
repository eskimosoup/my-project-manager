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

ActiveRecord::Schema.define(version: 20151218105559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name",                      null: false
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "brands", ["name"], name: "index_brands_on_name", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "customer_id",          null: false
    t.string   "name",                 null: false
    t.string   "email"
    t.string   "phone"
    t.string   "role",                 null: false
    t.datetime "made_main_contact_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "contacts", ["customer_id"], name: "index_contacts_on_customer_id", using: :btree
  add_index "contacts", ["made_main_contact_at"], name: "index_contacts_on_made_main_contact_at", using: :btree
  add_index "contacts", ["name"], name: "index_contacts_on_name", unique: true, using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.decimal  "credit_limit",     precision: 7, scale: 2, default: 0.0, null: false
    t.decimal  "amount_on_credit", precision: 7, scale: 2, default: 0.0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "customers", ["name"], name: "index_customers_on_name", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "substrate_cost", precision: 5, scale: 2,               null: false
    t.decimal  "hardware_cost",  precision: 5, scale: 2
    t.decimal  "ink_cost",       precision: 5, scale: 2
    t.decimal  "printer_cost",   precision: 5, scale: 2
    t.integer  "mark_up",                                default: 100, null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "project_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "project_id"
    t.decimal  "size",        precision: 7, scale: 2, null: false
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "project_items", ["product_id"], name: "index_project_items_on_product_id", using: :btree
  add_index "project_items", ["project_id"], name: "index_project_items_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "name",                    null: false
    t.text     "description"
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["status"], name: "completed", where: "(status = 2)", using: :btree
  add_index "projects", ["status"], name: "index_projects_on_status", using: :btree
  add_index "projects", ["status"], name: "quoted", where: "(status = 0)", using: :btree
  add_index "projects", ["status"], name: "sold", where: "(status = 1)", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",                                          null: false
    t.boolean  "admin",                          default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "contacts", "customers", on_delete: :cascade
  add_foreign_key "project_items", "products"
  add_foreign_key "project_items", "projects", on_delete: :cascade
  add_foreign_key "projects", "customers", on_delete: :cascade
end
