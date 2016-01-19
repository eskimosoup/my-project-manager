class AddBrandTypeToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :brand_type, :integer, null: false, default: 0
  end
end
