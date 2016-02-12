class AddPurchaseOrderToProject < ActiveRecord::Migration
  def change
    add_column :projects, :purchase_order, :string, null: true
  end
end
