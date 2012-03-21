class AddIndexesRailsBp < ActiveRecord::Migration
  def change
    add_index :comments, :user_story_id
    add_index :comments, :user_id
    add_index :project_settings, :project_id
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
    add_index :user_stories, :sprint_id
    add_index :user_stories_users, :user_id
    add_index :user_stories_users, :user_story_id
  end
end

