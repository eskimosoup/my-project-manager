class CreateSupportingProductItems < ActiveRecord::Migration
  def change
    create_table :supporting_product_items do |t|
      t.decimal :area, null: false, precision: 15, scale: 3
      t.belongs_to :supporting_product, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.belongs_to :print_job, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
