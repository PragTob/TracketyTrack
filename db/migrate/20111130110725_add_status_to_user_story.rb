class AddStatusToUserStory < ActiveRecord::Migration
  def change
    add_column :user_stories, :status, :string
  end
end
