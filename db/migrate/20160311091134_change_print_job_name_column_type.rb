class ChangePrintJobNameColumnType < ActiveRecord::Migration
  def up
    change_column :print_jobs, :name, :text
  end

  def down
    change_column :print_jobs, :name, :string
  end
end
