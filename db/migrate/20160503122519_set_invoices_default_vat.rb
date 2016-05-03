class SetInvoicesDefaultVat < ActiveRecord::Migration
  def change
    change_column_default :invoices, :vat, 0
  end
end
