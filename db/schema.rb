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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120108193915) do

  create_table "comments", :force => true do |t|
    t.integer  "user_story_id"
    t.integer  "user_id"
    t.datetime "date"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "repository_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_sprint_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sprints", :force => true do |t|
    t.integer  "number"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "velocity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "user_stories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "acceptance_criteria"
    t.integer  "priority"
    t.integer  "estimation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "sprint_id"
    t.integer  "work_effort"
    t.datetime "start_time"
    t.datetime "close_time"
    t.boolean  "requesting_feedback"
  end

  create_table "user_stories_users", :force => true do |t|
    t.integer "user_story_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "accepted"
  end

end
