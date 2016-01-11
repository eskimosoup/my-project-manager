class CreateSupportingProducts < ActiveRecord::Migration
  def change
    create_table :supporting_products do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.decimal :substrate_cost, precision: 7, scale: 2, null: false
      t.integer :mark_up, null: false, default: 100

      t.timestamps null: false
    end
  end
end
