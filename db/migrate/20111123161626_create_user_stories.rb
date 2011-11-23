class CreateUserStories < ActiveRecord::Migration
  def change
    create_table :user_stories do |t|
      t.string :name
      t.text :description
      t.text :acceptance_criteria
      t.integer :priority
      t.integer :estimation

      t.timestamps
    end
  end
end

