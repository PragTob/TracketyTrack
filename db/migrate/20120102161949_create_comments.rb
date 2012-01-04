class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_story_id
      t.integer :user_id
      t.datetime :date
      t.text :content

      t.timestamps
    end
  end
end
