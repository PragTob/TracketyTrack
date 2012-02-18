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

ActiveRecord::Schema.define(:version => 20120218222212) do

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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

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
    t.string   "email"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "accepted"
  end

end
