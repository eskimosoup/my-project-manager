class AddPricesToPrintJobs < ActiveRecord::Migration
  def change
    add_column :print_jobs, :envisage_sale_price, :decimal, precision: 10, scale: 2
    add_column :print_jobs, :envisage_trade_sale_price, :decimal, precision: 10, scale: 2
    add_column :print_jobs, :envisage_to_my_sale_price, :decimal, precision: 10, scale: 2
    add_column :print_jobs, :my_sale_price, :decimal, precision: 10, scale: 2
  end
end
