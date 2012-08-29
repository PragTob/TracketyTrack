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

ActiveRecord::Schema.define(:version => 20120829185512) do

  create_table "comments", :force => true do |t|
    t.integer  "user_story_id"
    t.integer  "user_id"
    t.datetime "date"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["user_story_id"], :name => "index_comments_on_user_story_id"

  create_table "project_settings", :force => true do |t|
    t.string   "travis_ci_repo"
    t.datetime "travis_last_updated"
    t.integer  "project_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "project_settings", ["project_id"], :name => "index_project_settings_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "repository_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "current_sprint_id"
  end

  create_table "sprints", :force => true do |t|
    t.integer  "number"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "velocity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "user_stories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "acceptance_criteria"
    t.integer  "priority"
    t.integer  "estimation"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "status"
    t.integer  "sprint_id"
    t.integer  "work_effort"
    t.datetime "start_time"
    t.datetime "close_time"
    t.boolean  "requesting_feedback"
  end

  add_index "user_stories", ["sprint_id"], :name => "index_user_stories_on_sprint_id"

  create_table "user_stories_users", :force => true do |t|
    t.integer "user_story_id"
    t.integer "user_id"
  end

  add_index "user_stories_users", ["user_id"], :name => "index_user_stories_users_on_user_id"
  add_index "user_stories_users", ["user_story_id"], :name => "index_user_stories_users_on_user_story_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "salt"
    t.boolean  "accepted"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
