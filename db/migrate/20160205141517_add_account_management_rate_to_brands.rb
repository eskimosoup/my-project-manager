class AddAccountManagementRateToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :account_management_rate, :decimal, null: false, precision: 6, scale: 2, default: 0.00
  end
end
