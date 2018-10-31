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

ActiveRecord::Schema.define(version: 2018_10_31_165356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "saas_plans", force: :cascade do |t|
    t.bigint "product_id"
    t.string "name"
    t.string "stripe_id"
    t.integer "price_in_cents"
    t.string "interval"
    t.integer "trial_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_saas_plans_on_product_id"
  end

  create_table "saas_products", force: :cascade do |t|
    t.string "name"
    t.string "stripe_id"
    t.string "statement_descriptor"
    t.string "unit_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plans_count", default: 0
  end

  add_foreign_key "saas_plans", "saas_products", column: "product_id"
end
