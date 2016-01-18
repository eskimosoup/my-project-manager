class CreateBrandAddresses < ActiveRecord::Migration
  def change
    create_table :brand_addresses do |t|
      t.references :brand, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :line_1, null: false
      t.string :line_2
      t.string :line_3
      t.string :city, null: false
      t.string :postcode, null: false

      t.timestamps null: false
    end
  end
end
