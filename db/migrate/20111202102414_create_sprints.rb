class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :number
      t.datetime :start_date
      t.datetime :end_date
      t.integer :velocity

      t.timestamps
    end
  end
end
