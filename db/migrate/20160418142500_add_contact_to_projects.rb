class AddContactToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :contact, index: true, foreign_key: true
  end
end
