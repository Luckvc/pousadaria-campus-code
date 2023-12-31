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

ActiveRecord::Schema[7.1].define(version: 2023_12_01_143913) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "additional_guests", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.integer "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_additional_guests_on_reservation_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "cep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consumables", force: :cascade do |t|
    t.string "description"
    t.decimal "price", precision: 8, scale: 10
    t.integer "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_consumables_on_reservation_id"
  end

  create_table "custom_dates", force: :cascade do |t|
    t.date "begin"
    t.date "end"
    t.decimal "price", precision: 8, scale: 10
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_custom_dates_on_room_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "inns", force: :cascade do |t|
    t.string "name"
    t.string "company_name"
    t.string "cnpj"
    t.string "phone"
    t.string "email"
    t.integer "address_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pets", default: false
    t.boolean "active", default: true
    t.string "policies"
    t.string "check_in_time", default: "14:00"
    t.string "check_out_time", default: "12:00"
    t.boolean "pix", default: false
    t.boolean "credit", default: false
    t.boolean "debit", default: false
    t.boolean "cash", default: false
    t.index ["address_id"], name: "index_inns_on_address_id"
    t.index ["user_id"], name: "index_inns_on_user_id"
  end

  create_table "pre_reservations", force: :cascade do |t|
    t.date "check_in_date"
    t.date "check_out_date"
    t.integer "guests"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total"
    t.index ["room_id"], name: "index_pre_reservations_on_room_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "check_in_date"
    t.date "check_out_date"
    t.integer "guests"
    t.integer "total"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id", null: false
    t.string "code"
    t.integer "status", default: 2
    t.datetime "checked_in_datetime"
    t.datetime "checked_out_datetime"
    t.string "payment_method"
    t.boolean "paid", default: false
    t.index ["customer_id"], name: "index_reservations_on_customer_id"
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "score"
    t.text "message"
    t.integer "customer_id", null: false
    t.integer "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "answer"
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "number"
    t.string "description"
    t.integer "double_beds"
    t.integer "single_beds"
    t.integer "capacity"
    t.decimal "price", precision: 8, scale: 10
    t.integer "bathrooms"
    t.boolean "kitchen", default: false
    t.integer "inn_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.integer "dimension", default: 0
    t.boolean "balcony", default: false
    t.boolean "air", default: false
    t.boolean "tv", default: false
    t.boolean "wardrobe", default: false
    t.boolean "safe", default: false
    t.boolean "accessible", default: false
    t.index ["inn_id"], name: "index_rooms_on_inn_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.boolean "host", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "additional_guests", "reservations"
  add_foreign_key "consumables", "reservations"
  add_foreign_key "custom_dates", "rooms"
  add_foreign_key "inns", "addresses"
  add_foreign_key "inns", "users"
  add_foreign_key "pre_reservations", "rooms"
  add_foreign_key "reservations", "customers"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "reviews", "customers"
  add_foreign_key "reviews", "reservations"
  add_foreign_key "rooms", "inns"
end
