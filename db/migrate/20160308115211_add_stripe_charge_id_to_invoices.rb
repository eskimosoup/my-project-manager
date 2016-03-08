class AddStripeChargeIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :stripe_charge_id, :string
    add_index :invoices, :stripe_charge_id
  end
end
