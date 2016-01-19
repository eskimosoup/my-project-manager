class CreateSundryItems < ActiveRecord::Migration
  def change
    create_table :sundry_items do |t|
      t.string :name, null: false
      t.decimal :cost, null: false, scale: 2, precision: 15
      t.belongs_to :print_job, index: true, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps null: false
    end
  end
end
