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

ActiveRecord::Schema.define(version: 20140108150820) do

  create_table "accident_insurances", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accident_items", force: true do |t|
    t.integer  "accident_insurance_id"
    t.integer  "industry_id"
    t.string   "employee_number"
    t.integer  "quota"
    t.date     "started_at"
    t.date     "stopped_at"
    t.integer  "accident_medical"
    t.integer  "hospital_allowance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accident_items", ["accident_insurance_id"], name: "index_accident_items_on_accident_insurance_id"
  add_index "accident_items", ["industry_id"], name: "index_accident_items_on_industry_id"

  create_table "admin_profiles", force: true do |t|
    t.string   "name",       default: "", null: false
    t.text     "aboutme",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

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

  create_table "elevators", force: true do |t|
    t.integer  "public_liability_item_id"
    t.string   "kind"
    t.integer  "quantity"
    t.date     "year_of_manufacture"
    t.integer  "using_years"
    t.integer  "overhaul_interval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "elevators", ["public_liability_item_id"], name: "index_elevators_on_public_liability_item_id"

  create_table "employer_liability_employees", force: true do |t|
    t.integer  "employer_liability_item_id"
    t.string   "name"
    t.string   "title"
    t.string   "health"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employer_liability_employees", ["employer_liability_item_id"], name: "index_employees_on_employer_liability_item_id"

  create_table "employer_liability_items", force: true do |t|
    t.integer  "insurance_id"
    t.integer  "business_nature"
    t.integer  "bodily_injury_limit"
    t.integer  "medical_expenses_limit"
    t.integer  "litigation_costs_limit"
    t.integer  "within_period_aggregate_limit"
    t.integer  "deductibles"
    t.integer  "each_accident_limit"
    t.integer  "each_accident_bodily_injury_limit"
    t.integer  "aggregate_limit"
    t.integer  "property_deductibles"
    t.integer  "employee_number"
    t.date     "effective_date"
    t.date     "termination_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employer_liability_items", ["insurance_id"], name: "index_employer_liability_items_on_insurance_id"

  create_table "health_insurances", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insurances", force: true do |t|
    t.string   "title"
    t.text     "synopsis"
    t.decimal  "price"
    t.string   "aasm_state"
    t.string   "type"
    t.integer  "company_id"
    t.string   "image"
    t.string   "target"
    t.text     "feature"
    t.text     "benefit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "insurances", ["company_id"], name: "index_insurances_on_company_id"

  create_table "insured_products", force: true do |t|
    t.integer  "product_liability_item_id"
    t.string   "name"
    t.string   "kind"
    t.string   "nature"
    t.string   "use"
    t.string   "sales_area"
    t.string   "sales_volumn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "insured_products", ["product_liability_item_id"], name: "index_insured_products_on_product_liability_item_id"

  create_table "line_items", force: true do |t|
    t.integer  "insurance_item_id"
    t.string   "insurance_item_type"
    t.integer  "user_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.string   "aasm_state"
    t.decimal  "price"
    t.integer  "quantity",            default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["insurance_item_id", "insurance_item_type"], name: "index_line_items_on_insurance_item_id_and_insurance_item_type"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id"

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
    t.integer  "user_id"
    t.string   "aasm_state"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "park_profiles", force: true do |t|
    t.string   "name"
    t.string   "park_name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_liability_items", force: true do |t|
    t.integer  "insurance_id"
    t.integer  "business_nature"
    t.integer  "each_accident_limit"
    t.integer  "bodily_injury_limit"
    t.integer  "property_damage_limit"
    t.integer  "aggregate_limit"
    t.date     "started_at"
    t.date     "stopped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_liability_items", ["insurance_id"], name: "index_product_liability_items_on_insurance_id"

  create_table "public_liability_items", force: true do |t|
    t.integer  "insurance_id"
    t.string   "business_place"
    t.integer  "business_type"
    t.boolean  "with_fire_control"
    t.boolean  "with_security_measure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "public_liability_items", ["insurance_id"], name: "index_public_liability_items_on_insurance_id"

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

  create_table "traces", force: true do |t|
    t.integer  "tracer_id",      null: false
    t.string   "tracer_type",    null: false
    t.integer  "traceable_id",   null: false
    t.string   "traceable_type", null: false
    t.string   "action",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traces", ["traceable_id", "traceable_type"], name: "index_traces_on_traceable_id_and_traceable_type"
  add_index "traces", ["tracer_id", "tracer_type"], name: "index_traces_on_tracer_id_and_tracer_type"

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
