class RenameMyPrintServicesItemsToMyServiceItems < ActiveRecord::Migration
  def change
    rename_table :my_print_services_items, :my_service_items
  end
end
