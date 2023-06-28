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

ActiveRecord::Schema[7.0].define(version: 2023_06_28_022652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "mode", ["public", "private"]
  create_enum "user_status", ["active", "inactive"]

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "album_imgs", force: :cascade do |t|
    t.bigint "album_id_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id_id"], name: "index_album_imgs_on_album_id_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.enum "sharing_mode", default: "public", null: false, enum_type: "mode"
    t.integer "total_like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "contains", force: :cascade do |t|
    t.bigint "album_id_id"
    t.bigint "photo_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id_id"], name: "index_contains_on_album_id_id"
    t.index ["photo_id_id"], name: "index_contains_on_photo_id_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "manages", force: :cascade do |t|
    t.bigint "admin_id_id"
    t.bigint "user_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id_id"], name: "index_manages_on_admin_id_id"
    t.index ["user_id_id"], name: "index_manages_on_user_id_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.enum "sharing_mode", default: "public", null: false, enum_type: "mode"
    t.string "image_url"
    t.integer "total_like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "avatar_url"
    t.enum "status", default: "active", null: false, enum_type: "user_status"
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "album_imgs", "albums", column: "album_id_id"
  add_foreign_key "albums", "users"
  add_foreign_key "contains", "albums", column: "album_id_id"
  add_foreign_key "contains", "photos", column: "photo_id_id"
  add_foreign_key "follows", "users", column: "followee_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "manages", "admins", column: "admin_id_id"
  add_foreign_key "manages", "users", column: "user_id_id"
  add_foreign_key "photos", "users"
end
