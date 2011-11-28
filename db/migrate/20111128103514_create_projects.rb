class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :titel
      t.text :description
      t.string :repository_url

      t.timestamps
    end
  end
end
