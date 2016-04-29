class AddCostToPrintJobs < ActiveRecord::Migration
  def change
    add_column :print_jobs, :cost, :decimal, precision: 10, scale: 2
  end
end
