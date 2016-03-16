class CreateVehicleWrapsMaterials < ActiveRecord::Migration
  def change
    create_table :vehicle_wraps_materials do |t|
      t.decimal :area, null: false, precision: 15, scale: 3
      t.belongs_to :vehicle_wrap, index: true, foreign_key: { on_delete: :cascade }
      t.belongs_to :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
