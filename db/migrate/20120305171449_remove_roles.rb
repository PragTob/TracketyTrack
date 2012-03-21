class RemoveRoles < ActiveRecord::Migration
  def change
    drop_table 'roles'
    drop_table 'roles_users'
  end
end

