class CreateSupportingProductCosts < ActiveRecord::Migration
  def change
    create_table :supporting_product_costs do |t|
      t.belongs_to :supporting_product, index: true, foreign_key: { on_delete: :cascade }
      t.belongs_to :print_job, index: true, foreign_key: { on_delete: :cascade }
      t.decimal :cost, precision: 15, scale: 2, null: false
      t.decimal :area, precision: 15, scale: 3, null: false

      t.timestamps null: false
    end
  end
end
