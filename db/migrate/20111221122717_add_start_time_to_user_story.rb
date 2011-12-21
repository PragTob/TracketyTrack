class AddStartTimeToUserStory < ActiveRecord::Migration
  def change
    add_column :user_stories, :start_time, :datetime
  end
end

