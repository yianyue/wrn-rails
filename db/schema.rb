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

ActiveRecord::Schema.define(version: 20160430162049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.text     "content"
    t.integer  "word_count"
    t.integer  "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "preview"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.integer  "goal"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "token"
    t.string   "time_zone"
  end

  add_foreign_key "entries", "users"
end
