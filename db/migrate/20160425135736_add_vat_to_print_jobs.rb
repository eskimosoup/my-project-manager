class AddVatToPrintJobs < ActiveRecord::Migration
  def change
    add_column :print_jobs, :vat, :boolean, default: true, null: false
  end
end
