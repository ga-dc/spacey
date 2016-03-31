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

ActiveRecord::Schema.define(version: 20160115170904) do

  create_table "event_types", force: :cascade do |t|
    t.string "color"
    t.string "title"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start_date"
    t.datetime "start_time"
    t.datetime "end_date"
    t.datetime "end_time"
    t.integer  "recurring_event_id"
    t.integer  "space_id"
  end

  add_index "events", ["recurring_event_id"], name: "index_events_on_recurring_event_id"
  add_index "events", ["space_id"], name: "index_events_on_space_id"

  create_table "recurring_events", force: :cascade do |t|
    t.string  "title"
    t.integer "event_type_id"
  end

  add_index "recurring_events", ["event_type_id"], name: "index_recurring_events_on_event_type_id"

  create_table "spaces", force: :cascade do |t|
    t.string  "title"
    t.integer "capacity"
  end

end
