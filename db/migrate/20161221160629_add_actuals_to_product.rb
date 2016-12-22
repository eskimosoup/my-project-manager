class AddActualsToProduct < ActiveRecord::Migration
  def change
    add_column :product_items, :actual_cost, :decimal,
               precision: 10, scale: 2, null: true
    add_column :product_items, :actual_area, :decimal,
               precision: 15, scale: 3, null: true

    add_column :supporting_product_items, :actual_area, :decimal,
               precision: 15, scale: 3, null: true
    add_column :supporting_product_items, :actual_cost, :decimal,
               precision: 10, scale: 2, null: true

    add_column :labour_items, :actual_cost, :decimal,
               precision: 10, scale: 2, null: true
    add_column :labour_items, :actual_hours, :decimal,
               precision: 15, scale: 2, null: true

    add_column :sundry_items, :actual_cost, :decimal,
               precision: 10, scale: 2, null: true

    add_column :job_specifications, :actual_hours, :decimal,
               precision: 15, scale: 2, null: true

    add_column :mileages, :actual_miles, :decimal,
               precision: 15, scale: 2, null: true

    add_column :account_managements, :actual_hours, :decimal,
               precision: 15, scale: 2, null: true

    add_column :designs, :actual_hours, :decimal,
               precision: 15, scale: 2, null: true

    add_column :my_service_items, :actual_cost, :decimal,
               precision: 10, scale: 2, null: true
  end
end
