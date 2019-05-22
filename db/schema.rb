# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_22_193825) do

  create_table "adminpanel_auths", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_adminpanel_auths_on_key"
    t.index ["name"], name: "index_adminpanel_auths_on_name"
  end

  create_table "adminpanel_images", force: :cascade do |t|
    t.string "file"
    t.integer "model_id"
    t.string "model_type"
    t.string "type"
    t.string "file_size"
    t.string "content_type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adminpanel_pages", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.text "fields"
  end

  create_table "adminpanel_permissions", force: :cascade do |t|
    t.integer "role_id"
    t.integer "action"
    t.string "resource"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adminpanel_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adminpanel_sections", force: :cascade do |t|
    t.string "name"
    t.boolean "has_description"
    t.text "description"
    t.string "key"
    t.string "page"
    t.boolean "has_image"
    t.integer "max_files", default: 0
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_adminpanel_sections_on_key"
    t.index ["page"], name: "index_adminpanel_sections_on_page"
  end

  create_table "adminpanel_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role_id"
    t.string "password_digest"
    t.string "remember_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_adminpanel_users_on_email"
    t.index ["remember_token"], name: "index_adminpanel_users_on_remember_token"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name"
    t.string "location"
    t.string "image_url"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

end
