class AddDescriptionToPrintJobs < ActiveRecord::Migration
  def change
    add_column :print_jobs, :description, :text, null: true
  end
end
