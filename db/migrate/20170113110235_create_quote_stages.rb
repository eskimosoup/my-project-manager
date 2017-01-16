class CreateQuoteStages < ActiveRecord::Migration
  def change
    create_table :quote_stages do |t|
      t.string :name, null: false
      t.integer :chance, null: false

      t.timestamps null: false
    end
  end
end
