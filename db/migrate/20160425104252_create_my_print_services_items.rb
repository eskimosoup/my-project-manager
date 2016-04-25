class CreateMyPrintServicesItems < ActiveRecord::Migration
  def change
    create_table :my_print_services_items do |t|
      t.string :name, null: false
      t.decimal :cost, null: false, precision: 15, scale: 2
      t.belongs_to :print_job, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
