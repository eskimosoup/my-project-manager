class AddShippingAddressAndBillingAddressToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :shipping_address, index: true
    add_reference :projects, :billing_address, index: true
    add_foreign_key :projects, :addresses, column: :shipping_address_id, on_delete: :cascade
    add_foreign_key :projects, :addresses, column: :billing_address_id, on_delete: :cascade
  end
end
