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

ActiveRecord::Schema.define(version: 20131208175717) do

  create_table "accident_insurances", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_profiles", force: true do |t|
    t.string   "name",       default: "", null: false
    t.text     "aboutme",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.integer  "customer_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["customer_profile_id"], name: "index_carts_on_customer_profile_id"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "aboutme"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_profiles", force: true do |t|
    t.string   "name"
    t.string   "enterprise_name"
    t.string   "location"
    t.integer  "park_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_profiles", ["park_profile_id"], name: "index_customer_profiles_on_park_profile_id"

  create_table "health_insurances", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insurances", force: true do |t|
    t.string   "title"
    t.text     "synopsis"
    t.decimal  "price"
    t.string   "workflow_state"
    t.integer  "company_id"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "insurances", ["company_id"], name: "index_insurances_on_company_id"
  add_index "insurances", ["profile_id", "profile_type"], name: "index_insurances_on_profile_id_and_profile_type"

  create_table "line_items", force: true do |t|
    t.integer  "insurance_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.string   "workflow_state"
    t.decimal  "price"
    t.integer  "quantity",       default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["insurance_id"], name: "index_line_items_on_insurance_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"

  create_table "manager_profiles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moderator_profiles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.datetime "deal_time"
    t.string   "address"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "park_profiles", force: true do |t|
    t.string   "name"
    t.string   "park_name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quoter_profiles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               default: "", null: false
    t.integer  "profile_id"
    t.string   "profile_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["profile_id", "profile_type"], name: "index_users_on_profile_id_and_profile_type"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
