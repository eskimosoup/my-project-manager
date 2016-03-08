class AddIndexToInvoicesSlugs < ActiveRecord::Migration
  def change
    add_index :invoices, :slug, unique: true
  end
end
