class CreatePrintJobs < ActiveRecord::Migration
  def change
    create_table :print_jobs do |t|
      t.belongs_to :project, index: true, foreign_key: { on_delete: :cascade }
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :print_jobs, [:project_id, :name], unique: true
  end
end
