class AddVehicleTypeToVehicleWraps < ActiveRecord::Migration
  def change
    add_reference :vehicle_wraps, :vehicle_type, index: true, foreign_key: { on_delete: :cascade }
  end
end
