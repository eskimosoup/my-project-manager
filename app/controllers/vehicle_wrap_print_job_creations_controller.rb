class VehicleWrapPrintJobCreationsController < ApplicationController
  def create
    vehicle_wrap_print_job_creator = VehicleWrapPrintJobCreator.new(vehicle_wrap_id: params[:vehicle_wrap_id], project_id: params[:project_id])
    if vehicle_wrap_print_job_creator.save
      redirect_to vehicle_wrap_print_job_creator.project, notice: "Print Job Added"
    else
      redirect_to project_vehicle_wraps_path(vehicle_wrap_print_job_creator.project),
        alert: "Could not create print job"
    end
  end
end
