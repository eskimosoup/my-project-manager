class AddDeliveryAndNotesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :delivery_deadline, :date
    add_column :projects, :notes, :text
  end
end
