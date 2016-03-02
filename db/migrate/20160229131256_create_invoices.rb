class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :project, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.string :slug
      t.string :name, null: false
      t.integer :percentage, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.boolean :paid, null: false, default: false

      t.timestamps null: false
    end
  end
end
