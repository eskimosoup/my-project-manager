class CreateBrandAddresses < ActiveRecord::Migration
  def change
    create_table :brand_addresses do |t|
      t.belongs_to :brand, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.belongs_to :address, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
