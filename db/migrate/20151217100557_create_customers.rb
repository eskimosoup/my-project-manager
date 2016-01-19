class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, null: false, index: { unique: true }
      t.decimal :credit_limit, null: false, precision: 7, scale: 2, default: 0.0
      t.decimal :amount_on_credit, precision: 7, scale: 2, default: 0.0

      t.timestamps null: false
    end
  end
end
