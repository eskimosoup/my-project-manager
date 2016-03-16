class CreateVehicleWraps < ActiveRecord::Migration
  def change
    create_table :vehicle_wraps do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :envisage_override_price, precision: 10, scale: 2
      t.decimal :envisage_trade_override_price, precision: 10, scale: 2
      t.decimal :envisage_to_my_override_price, precision: 10, scale: 2
      t.decimal :my_override_price, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
