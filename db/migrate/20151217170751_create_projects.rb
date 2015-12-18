class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :customer, index: true, foreign_key: { on_delete: :cascade }
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0

      t.timestamps null: false
    end
    add_index :projects, :status
  end
end
