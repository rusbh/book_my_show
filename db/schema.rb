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

ActiveRecord::Schema[7.1].define(version: 2024_11_09_194214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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

  create_table "admin_requests", force: :cascade do |t|
    t.string "contact_email"
    t.bigint "contact_no"
    t.string "admin_emails"
    t.string "theater_name"
    t.text "theater_address"
    t.integer "pincode"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "ticket", default: 1
    t.date "booking_date"
    t.integer "status", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "screening_id", null: false
    t.bigint "show_timing_id", null: false
    t.decimal "total_price"
    t.index ["screening_id"], name: "index_bookings_on_screening_id"
    t.index ["show_timing_id"], name: "index_bookings_on_show_timing_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "event_requests", force: :cascade do |t|
    t.bigint "theater_id", null: false
    t.string "name"
    t.text "description"
    t.string "cast"
    t.string "languages", default: [], array: true
    t.string "genres", default: [], array: true
    t.integer "category"
    t.integer "duration", default: 120
    t.date "release_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.date "end_date"
    t.datetime "at_timeof"
    t.index ["theater_id"], name: "index_event_requests_on_theater_id"
    t.index ["user_id"], name: "index_event_requests_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "rating"
    t.index ["commentable_type", "commentable_id"], name: "index_feedbacks_on_commentable"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.bigint "screen_id", null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.string "language"
    t.index ["screen_id"], name: "index_screenings_on_screen_id"
    t.index ["show_id"], name: "index_screenings_on_show_id"
  end

  create_table "screens", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "theater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "screen_name"
    t.integer "seats", default: 150
    t.index ["theater_id"], name: "index_screens_on_theater_id"
  end

  create_table "show_timings", force: :cascade do |t|
    t.bigint "screening_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "at_timeof"
    t.integer "seats", default: 150
    t.index ["screening_id"], name: "index_show_timings_on_screening_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category"
    t.integer "status", default: 0
    t.integer "duration", default: 120
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "release_date"
    t.string "cast"
    t.string "slug"
    t.string "languages", default: [], array: true
    t.string "genres", default: [], array: true
    t.bigint "event_request_id"
    t.index ["event_request_id"], name: "index_shows_on_event_request_id"
    t.index ["slug"], name: "index_shows_on_slug", unique: true
  end

  create_table "theater_admins", force: :cascade do |t|
    t.bigint "theater_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["theater_id"], name: "index_theater_admins_on_theater_id"
    t.index ["user_id", "theater_id"], name: "unique_pair_of_user_and_theater", unique: true
    t.index ["user_id"], name: "index_theater_admins_on_user_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "status", default: 0
    t.integer "pincode"
    t.index ["slug"], name: "index_theaters_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "screenings"
  add_foreign_key "bookings", "show_timings"
  add_foreign_key "bookings", "users"
  add_foreign_key "event_requests", "theaters"
  add_foreign_key "event_requests", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "screenings", "screens"
  add_foreign_key "screenings", "shows"
  add_foreign_key "screens", "theaters"
  add_foreign_key "show_timings", "screenings"
  add_foreign_key "shows", "event_requests"
  add_foreign_key "theater_admins", "theaters"
  add_foreign_key "theater_admins", "users"
end
