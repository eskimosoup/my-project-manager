class CreateVehicleWrapsSupportingMaterials < ActiveRecord::Migration
  def change
    create_table :vehicle_wraps_supporting_materials do |t|
      t.decimal :area, null: false, precision: 15, scale: 3
      t.belongs_to :vehicle_wrap, index: { name: "vehicle_wrap_supporting materials" }, foreign_key: { on_delete: :cascade }
      t.belongs_to :supporting_product, index: { name: "supporting_product_supporting_materials" }, foreign_key: true

      t.timestamps null: false
    end
  end
end
