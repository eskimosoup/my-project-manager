class CreateLabours < ActiveRecord::Migration
  def change
    create_table :labours do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.decimal :per_hour, precision: 5, scale: 2, null: false
      t.integer :mark_up, null: false, default: 100

      t.timestamps null: false
    end
  end
end
