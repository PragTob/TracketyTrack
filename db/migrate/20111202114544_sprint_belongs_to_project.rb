class SprintBelongsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :current_sprint_id, :integer
  end
end

