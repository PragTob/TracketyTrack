class UserStoryBelongsToSprint < ActiveRecord::Migration
  def change
    add_column :user_stories, :sprint_id, :integer
  end
end

