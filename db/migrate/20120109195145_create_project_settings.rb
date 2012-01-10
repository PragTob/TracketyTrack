class CreateProjectSettings < ActiveRecord::Migration
  def change
    create_table :project_settings do |t|
      t.string :travis_ci_repo
      t.datetime :travis_last_updated
      t.integer :project_id

      t.timestamps
    end
  end
end

