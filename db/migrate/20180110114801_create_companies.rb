class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :base_invoice_number

      t.timestamps null: false
    end
  end
end
