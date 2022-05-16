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

ActiveRecord::Schema[7.0].define(version: 2022_05_13_192110) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_phone_numbers", force: :cascade do |t|
    t.string "name", null: false
    t.string "number"
    t.string "sid"
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.string "area_code", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_user_phone_numbers_on_discarded_at", where: "(discarded_at IS NULL)"
    t.index ["user_id", "name"], name: "index_user_phone_numbers_on_user_id_and_name", unique: true, where: "(discarded_at IS NULL)"
    t.index ["user_id"], name: "index_user_phone_numbers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.string "email"
    t.string "name"
    t.string "logo_url"
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "user_phone_numbers", "users"
end
