class VehicleWraps::DesignsController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @design = @vehicle_wrap.designs.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @design = @vehicle_wrap.designs.new(vehicle_wraps_design_params)
    if @design.save
      redirect_to @vehicle_wrap, notice: "Design created"
    else
      render :new
    end
  end

  def edit
    @design = find_vehicle_wraps_design
  end

  def update
    @design = find_vehicle_wraps_design
    if @design.update(vehicle_wraps_design_params)
      redirect_to vehicle_wrap_path(@design.vehicle_wrap_id), notice: "Design updated"
    else
      render :edit
    end
  end

  def destroy
    @design = find_vehicle_wraps_design
    @design.destroy
    redirect_to vehicle_wrap_path(@design.vehicle_wrap_id), notice: "Design removed"
  end

  private

  def find_vehicle_wraps_design
    VehicleWraps::Design.find(params[:id])
  end

  def vehicle_wraps_design_params
    params.require(:vehicle_wraps_design).permit(:hours)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
