class RemoveUniqueIndexOnContactName < ActiveRecord::Migration
  def change
    remove_index :contacts, column: :forename
  end
end
