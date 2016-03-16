class CreateVehicleTypes < ActiveRecord::Migration
  def change
    create_table :vehicle_types do |t|
      t.string :name, index: { unique: true }, null: false

      t.timestamps null: false
    end
  end
end
