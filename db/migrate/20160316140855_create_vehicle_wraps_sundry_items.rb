class CreateVehicleWrapsSundryItems < ActiveRecord::Migration
  def change
    create_table :vehicle_wraps_sundry_items do |t|
      t.decimal :cost, null: false, precision: 15, scale: 2
      t.belongs_to :vehicle_wrap, index: true, foreign_key: { on_delete: :cascade }
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
