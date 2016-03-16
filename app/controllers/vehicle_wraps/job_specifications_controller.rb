class VehicleWraps::JobSpecificationsController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @job_specification = @vehicle_wrap.job_specifications.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @job_specification = @vehicle_wrap.job_specifications.new(vehicle_wraps_job_specification_params)
    if @job_specification.save
      redirect_to @vehicle_wrap, notice: "Job Specification created"
    else
      render :new
    end
  end

  def edit
    @job_specification = find_vehicle_wraps_job_specification
  end

  def update
    @job_specification = find_vehicle_wraps_job_specification
    if @job_specification.update(vehicle_wraps_job_specification_params)
      redirect_to vehicle_wrap_path(@job_specification.vehicle_wrap_id), notice: "Job Specification updated"
    else
      render :edit
    end
  end

  def destroy
    @job_specification = find_vehicle_wraps_job_specification
    @job_specification.destroy
    redirect_to vehicle_wrap_path(@job_specification.vehicle_wrap_id), notice: "Job Specification removed"
  end

  private

  def find_vehicle_wraps_job_specification
    VehicleWraps::JobSpecification.find(params[:id])
  end

  def vehicle_wraps_job_specification_params
    params.require(:vehicle_wraps_job_specification).permit(:hours)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
