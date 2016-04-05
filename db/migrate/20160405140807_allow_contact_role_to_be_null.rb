class AllowContactRoleToBeNull < ActiveRecord::Migration
  def change
    change_column_null :contacts, :role, true
  end
end
