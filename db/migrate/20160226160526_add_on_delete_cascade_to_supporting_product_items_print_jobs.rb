class AddOnDeleteCascadeToSupportingProductItemsPrintJobs < ActiveRecord::Migration
  def up
    remove_foreign_key :supporting_product_items, :print_jobs
    add_foreign_key :supporting_product_items, :print_jobs, on_delete: :cascade
  end

  def down
    remove_foreign_key :supporting_product_items, :print_jobs
    add_foreign_key :supporting_product_items, :print_jobs
  end
end
