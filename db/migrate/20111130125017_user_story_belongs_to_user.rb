class UserStoryBelongsToUser < ActiveRecord::Migration
  def change
    add_column :user_stories, :user_id, :integer
  end
end

