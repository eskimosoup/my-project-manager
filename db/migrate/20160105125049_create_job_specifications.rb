class CreateJobSpecifications < ActiveRecord::Migration
  def change
    create_table :job_specifications do |t|
      t.decimal :hours, null: false, scale: 2, precision: 15
      t.belongs_to :print_job, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
