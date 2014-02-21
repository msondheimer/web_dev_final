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

ActiveRecord::Schema.define(version: 20140221005252) do

  create_table "char_tags", force: true do |t|
    t.integer  "photo"
    t.integer  "character"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.string   "franchise"
    t.text     "cosplaying"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conventions", force: true do |t|
    t.string   "name"
    t.string   "genre"
    t.string   "city"
    t.string   "venue"
    t.string   "con_url"
    t.integer  "expected_size"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lon"
  end

  create_table "photos", force: true do |t|
    t.string   "photo_url"
    t.integer  "con"
    t.integer  "posting_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

end
