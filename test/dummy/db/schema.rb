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

ActiveRecord::Schema.define(version: 20130715152615) do

  create_table "spina_accounts", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.text     "preferences"
    t.string   "logo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "spina_file_collections", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_file_collections_files", force: true do |t|
    t.integer "file_collection_id"
    t.integer "file_id"
  end

  create_table "spina_files", force: true do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_inquiries", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.boolean  "archived",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "spam"
  end

  create_table "spina_page_parts", force: true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "page_id"
    t.text     "content"
    t.integer  "page_partable_id"
    t.string   "page_partable_type"
  end

  create_table "spina_pages", force: true do |t|
    t.string   "title"
    t.string   "menu_title"
    t.string   "description"
    t.boolean  "show_in_menu", default: true
    t.string   "slug"
    t.boolean  "deletable",    default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "parent_id"
    t.string   "name"
    t.string   "seo_title"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "spina_photo_collections", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_photo_collections_photos", force: true do |t|
    t.integer "photo_collection_id"
    t.integer "photo_id"
  end

  create_table "spina_photos", force: true do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "last_logged_in"
  end

end
