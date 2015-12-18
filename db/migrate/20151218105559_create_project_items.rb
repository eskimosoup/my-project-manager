class CreateProjectItems < ActiveRecord::Migration
  def change
    create_table :project_items do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :project, index: true, foreign_key: { on_delete: :cascade }
      t.decimal :size, precision: 7, scale: 2, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
