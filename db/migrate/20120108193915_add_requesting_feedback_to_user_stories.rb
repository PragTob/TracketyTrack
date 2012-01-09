class AddRequestingFeedbackToUserStories < ActiveRecord::Migration
  def change
    add_column :user_stories, :requesting_feedback, :boolean
  end
end

