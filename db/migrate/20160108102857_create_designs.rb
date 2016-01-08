class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.belongs_to :project, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.decimal :hours, precision: 15, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
