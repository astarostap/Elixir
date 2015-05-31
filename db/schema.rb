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

ActiveRecord::Schema.define(version: 20150529114810) do

  create_table "agrees", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "response_id"
    t.integer  "voter_id"
    t.integer  "is_doctor"
    t.integer  "vote_value"
  end

  create_table "doctor_votes", force: true do |t|
    t.integer  "optionNum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "doctor_id"
  end

  create_table "doctors", force: true do |t|
    t.integer  "docScore"
    t.string   "specialty"
    t.string   "school"
    t.string   "knownFor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.text     "gender"
    t.text     "location"
    t.datetime "birth_date"
    t.integer  "years_in_practice"
    t.string   "profile_pic"
  end

  create_table "normal_users", force: true do |t|
    t.string   "username"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "email"
    t.datetime "birth_date"
    t.text     "gender"
    t.text     "location"
    t.string   "profile_pic"
  end

  create_table "papers", force: true do |t|
    t.integer  "optionNum"
    t.string   "url"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.text     "img_path"
    t.text     "title"
  end

  create_table "questions", force: true do |t|
    t.string   "title"
    t.string   "text"
    t.string   "option1"
    t.string   "option2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_link"
    t.integer  "normal_user_id"
  end

  create_table "responses", force: true do |t|
    t.integer  "agreesNum"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.integer  "user_id"
    t.integer  "is_doctor"
    t.integer  "question_id"
    t.integer  "option_num"
    t.integer  "optionNum"
  end

  create_table "user_votes", force: true do |t|
    t.integer  "optionNum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "user_id"
  end

end
