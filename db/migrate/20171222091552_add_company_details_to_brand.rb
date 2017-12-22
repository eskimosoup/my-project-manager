class AddCompanyDetailsToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :vat_no, :string
    add_column :brands, :company_name, :string
    add_column :brands, :company_reg_no, :string
    add_column :brands, :address_text, :string
    add_column :brands, :bank_sort_code, :string
    add_column :brands, :bank_account_number, :string
  end
end
