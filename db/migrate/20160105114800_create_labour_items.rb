class CreateLabourItems < ActiveRecord::Migration
  def change
    create_table :labour_items do |t|
      t.belongs_to :print_job, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.belongs_to :labour, index: true, foreign_key: true, null: false
      t.decimal :hours, null: false, precision: 15, scale: 2

      t.timestamps null: false
    end
  end
end
