class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
