class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :customer, null: false, index: true, foreign_key: { on_delete: :cascade }
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :role, null: false
      t.datetime :made_main_contact_at
      t.timestamps null: false
    end
    add_index :contacts, :name, unique: true
    add_index :contacts, :made_main_contact_at
  end
end
