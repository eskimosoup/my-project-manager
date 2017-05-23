class AddPositionToPrintJob < ActiveRecord::Migration
  def change
    add_column :print_jobs, :position, :integer
  end
end
