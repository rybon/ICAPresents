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

ActiveRecord::Schema.define(version: 20130619224543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "home", force: true do |t|
    t.datetime "ica_presents_begins"
    t.text     "program"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "teacher_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["teacher_id"], name: "index_messages_on_teacher_id", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "title"
    t.string   "students"
    t.string   "semester"
    t.string   "location"
    t.string   "time"
    t.text     "description"
    t.string   "picture"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["author_id", "author_type"], name: "index_projects_on_author_id_and_author_type", using: :btree
  add_index "projects", ["title", "students", "semester", "description"], name: "search", using: :btree

  create_table "students", force: true do |t|
    t.string   "facebook_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["facebook_id"], name: "index_students_on_facebook_id", unique: true, using: :btree

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "student_id"
    t.integer  "award_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["award_id"], name: "index_votes_on_award_id", using: :btree
  add_index "votes", ["project_id"], name: "index_votes_on_project_id", using: :btree
  add_index "votes", ["student_id", "award_id"], name: "index_votes_on_student_id_and_award_id", unique: true, using: :btree
  add_index "votes", ["student_id"], name: "index_votes_on_student_id", using: :btree

end
