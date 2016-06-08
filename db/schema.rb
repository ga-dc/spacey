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

ActiveRecord::Schema.define(version: 20160608165313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_types", force: :cascade do |t|
    t.string "color"
    t.string "title"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "space_id"
    t.string   "kind"
    t.string   "producer"
    t.string   "instructor"
    t.integer  "event_type_id"
    t.boolean  "approved"
    t.integer  "number_of_attendees"
    t.string   "event_style"
  end

  add_index "events", ["space_id"], name: "index_events_on_space_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "text"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["event_id"], name: "index_notes_on_event_id", using: :btree

  create_table "spaces", force: :cascade do |t|
    t.string  "title"
    t.integer "classroom_cap"
    t.integer "lecture_cap"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "spaces"
  add_foreign_key "notes", "events"
end
