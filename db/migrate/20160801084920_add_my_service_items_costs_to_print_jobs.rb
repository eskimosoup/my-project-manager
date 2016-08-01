class AddMyServiceItemsCostsToPrintJobs < ActiveRecord::Migration
  def change
    add_column :print_jobs, :my_service_item_costs, :decimal, default: 0.0
  end
end
