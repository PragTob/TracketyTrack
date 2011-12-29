class AddDescriptionToSprint < ActiveRecord::Migration
  def change
    add_column :sprints, :description, :text
  end
end
