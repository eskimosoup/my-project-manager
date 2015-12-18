class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.decimal :substrate_cost, null: false, precision: 5, scale: 2
      t.decimal :hardware_cost, precision: 5, scale: 2
      t.decimal :ink_cost, precision: 5, scale: 2
      t.decimal :printer_cost, precision: 5, scale: 2
      t.integer :mark_up, default: 100, null: false

      t.timestamps null: false
    end
  end
end
