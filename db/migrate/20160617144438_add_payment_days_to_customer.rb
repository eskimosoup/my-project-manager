class AddPaymentDaysToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :payment_days, :integer, default: 0
  end
end
