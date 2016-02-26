class AddOnDeleteCascadeToLabourItemsAndProductItems < ActiveRecord::Migration
  def up
    remove_foreign_key :labour_items, :labours
    add_foreign_key :labour_items, :labours, on_delete: :cascade
    remove_foreign_key :product_items, :products
    add_foreign_key :product_items, :products, on_delete: :cascade
  end

  def down
    remove_foreign_key :labour_items, :labours
    add_foreign_key :labour_items, :labours
    remove_foreign_key :product_items, :products
    add_foreign_key :product_items, :products
  end
end
