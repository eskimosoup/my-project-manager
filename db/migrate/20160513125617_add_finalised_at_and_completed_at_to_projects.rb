class AddFinalisedAtAndCompletedAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :finalised_at, :date
    add_column :projects, :completed_at, :date
  end
end
