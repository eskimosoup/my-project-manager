class AddFieldsForAmountInvoicesToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :type, :string, default: 'PercentageInvoice'
    add_column :invoices, :vat_items_description, :text
    add_column :invoices, :vat_items_total, :decimal, precision: 10, scale: 2
    add_column :invoices, :non_vat_items_description, :text
    add_column :invoices, :non_vat_items_total, :decimal, precision: 10, scale: 2
    change_column_null :invoices, :percentage, true
  end
end
