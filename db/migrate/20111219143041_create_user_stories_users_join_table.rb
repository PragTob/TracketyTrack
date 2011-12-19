class CreateUserStoriesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :user_stories_users do |t|
      t.integer :user_story_id
      t.integer :user_id
    end
  end
end

