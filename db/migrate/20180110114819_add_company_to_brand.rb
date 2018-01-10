class AddCompanyToBrand < ActiveRecord::Migration
  def change
    add_reference :brands, :company, index: true, foreign_key: true
  end
end
