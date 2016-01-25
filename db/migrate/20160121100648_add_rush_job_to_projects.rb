class AddRushJobToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :rush_job, :boolean, default: false
  end
end
