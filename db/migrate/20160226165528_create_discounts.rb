class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.belongs_to :project, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.string :description, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
