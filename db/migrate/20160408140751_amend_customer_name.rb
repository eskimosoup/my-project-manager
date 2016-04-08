class AmendCustomerName < ActiveRecord::Migration
  def up
    rename_column :contacts, :name, :forename
    add_column :contacts, :surname, :string, null: true
  end

  def down
    remove_column :contacts, :surname
    rename_column :contacts, :forename, :name
  end
end
