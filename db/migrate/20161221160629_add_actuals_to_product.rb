class AddActualsToProduct < ActiveRecord::Migration
  def change
    add_column :product_items, :actual_cost, :decimal, precision: 10, scale: 2, null: true
    add_column :product_items, :actual_area, :decimal, precision: 15, scale: 3, null: true
  end
end
