class CreateVehicleWrapsAccountManagements < ActiveRecord::Migration
  def change
    create_table :vehicle_wraps_account_managements do |t|
      t.decimal :hours, null: false, precision: 15, scale: 2
      t.belongs_to :vehicle_wrap, index: true, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps null: false
    end
  end
end
