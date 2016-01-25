class CreateSundryCosts < ActiveRecord::Migration
  def change
    create_table :sundry_costs do |t|
      t.string :name, null: false
      t.decimal :cost, precision: 15, scale: 2, null: false
      t.belongs_to :print_job, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
