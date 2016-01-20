class AddContactDetailsToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :telephone, :string
    add_column :brands, :email, :string
    add_column :brands, :website, :string
    add_column :brands, :terms_conditions_link, :string
  end
end
