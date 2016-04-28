class CreateEnvisageInvoices < ActiveRecord::Migration
  def change
    create_table :envisage_invoices do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :percentage, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.decimal :vat, null: false, precision: 10, scale: 2
      t.boolean :paid, null: false, default: false

      t.timestamps null: false
    end
  end
end
