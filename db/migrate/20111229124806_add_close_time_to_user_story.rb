class AddCloseTimeToUserStory < ActiveRecord::Migration
  def change
    add_column :user_stories, :close_time, :datetime
  end
end
