class AddAcceptedToUser < ActiveRecord::Migration
  def change
    add_column :users, :accepted, :boolean
  end
end
