# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_18_151212) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_fastpay", default: false
    t.boolean "has_quickpay", default: false
    t.boolean "has_superpay", default: false
    t.boolean "has_megapay", default: false
  end

  create_table "fastpay_configs", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "capture", default: false
    t.datetime "deleted_at"
    t.boolean "has_rate", default: false
    t.integer "installments"
    t.string "name"
    t.string "name_invoice"
    t.decimal "rate", precision: 19, scale: 2
    t.string "public_key"
    t.string "secret_key"
    t.string "production_url", default: "https://api.fastpay.com"
    t.string "sandbox_url", default: "https://sandbox.api.fastpay.com"
    t.string "slug"
    t.string "statement_descriptor"
    t.bigint "client_id"
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_fastpay_configs_on_client_id"
    t.index ["store_id"], name: "index_fastpay_configs_on_store_id"
  end

  create_table "gateways", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.string "production_url"
    t.string "sandbox_url"
    t.string "public_key"
    t.string "secret_key"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "megapay_configs", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "capture", default: false
    t.datetime "deleted_at"
    t.boolean "has_rate", default: false
    t.integer "installments"
    t.string "name"
    t.string "name_invoice"
    t.decimal "rate", precision: 19, scale: 2
    t.string "public_key"
    t.string "secret_key"
    t.string "production_url", default: "https://api.megapay.com"
    t.string "sandbox_url", default: "https://sandbox.api.megapay.com"
    t.string "slug"
    t.string "statement_descriptor"
    t.bigint "client_id"
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_megapay_configs_on_client_id"
    t.index ["store_id"], name: "index_megapay_configs_on_store_id"
  end

  create_table "quickpay_configs", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "capture", default: false
    t.datetime "deleted_at"
    t.boolean "has_rate", default: false
    t.integer "installments"
    t.string "name"
    t.string "name_invoice"
    t.decimal "rate", precision: 19, scale: 2
    t.string "public_key"
    t.string "secret_key"
    t.string "production_url", default: "https://api.quickpay.com"
    t.string "sandbox_url", default: "https://sandbox.api.quickpay.com"
    t.string "slug"
    t.string "statement_descriptor"
    t.bigint "client_id"
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_quickpay_configs_on_client_id"
    t.index ["store_id"], name: "index_quickpay_configs_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "superpay_configs", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "capture", default: false
    t.datetime "deleted_at"
    t.boolean "has_rate", default: false
    t.integer "installments"
    t.string "name"
    t.string "name_invoice"
    t.decimal "rate", precision: 19, scale: 2
    t.string "public_key"
    t.string "secret_key"
    t.string "production_url", default: "https://api.superpay.com"
    t.string "sandbox_url", default: "https://sandbox.api.superpay.com"
    t.string "slug"
    t.string "statement_descriptor"
    t.bigint "client_id"
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_superpay_configs_on_client_id"
    t.index ["store_id"], name: "index_superpay_configs_on_store_id"
  end

  add_foreign_key "fastpay_configs", "clients"
  add_foreign_key "fastpay_configs", "stores"
  add_foreign_key "megapay_configs", "clients"
  add_foreign_key "megapay_configs", "stores"
  add_foreign_key "quickpay_configs", "clients"
  add_foreign_key "quickpay_configs", "stores"
  add_foreign_key "superpay_configs", "clients"
  add_foreign_key "superpay_configs", "stores"
end
