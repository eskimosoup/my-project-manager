class AddDueDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :due_date, :date
    reversible do |dir|
      dir.up do
        Invoice.reset_column_information
        Invoice.find_each do |invoice|
          invoice.update(due_date: invoice.created_at)
        end
      end
    end
    change_column_null :invoices, :due_date, false
  end
end
