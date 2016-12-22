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

ActiveRecord::Schema.define(version: 20161222182428) do

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.string   "beacon_ssn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_region_mappings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_region_mappings", ["region_id"], name: "index_user_region_mappings_on_region_id"
  add_index "user_region_mappings", ["user_id"], name: "index_user_region_mappings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "token"
    t.date     "token_expiry_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "profile_pic_url"
  end

end
