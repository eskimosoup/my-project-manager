class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, null: false, index: { unique: true }
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
