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

ActiveRecord::Schema.define(version: 20140508101023) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "num"
    t.integer  "create_time"
    t.integer  "pay_time"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scoolcourses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scools", force: true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "url"
    t.string   "profile_image_url"
    t.string   "location"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scoolteachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "telephone"
    t.integer  "gender"
    t.integer  "parent"
    t.integer  "is_default_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "profile_image_url"
    t.string   "telephone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
