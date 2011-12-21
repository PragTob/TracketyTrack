class AddWorkEffortToUserStory < ActiveRecord::Migration
  def change
    add_column :user_stories, :work_effort, :integer
  end
end

