class AddStatusPartialIndexesToProjects < ActiveRecord::Migration
  def change
    add_index :projects, :status, name: "quoted", where: "status = 0"
    add_index :projects, :status, name: "sold", where: "status = 1"
    add_index :projects, :status, name: "completed", where: "status = 2"
  end
end
