class ProjectVehicleWrapsController < ApplicationController
  def index
    @vehicle_wraps = VehicleWrap.all
  end
end
