class VehicleWraps::MaterialsController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @material = @vehicle_wrap.materials.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @material = @vehicle_wrap.materials.new(vehicle_wraps_material_params)
    if @material.save
      redirect_to @vehicle_wrap, notice: "Material created"
    else
      render :new
    end
  end

  def edit
    @material = find_vehicle_wraps_material
  end

  def update
    @material = find_vehicle_wraps_material
    if @material.update(vehicle_wraps_material_params)
      redirect_to vehicle_wrap_path(@material.vehicle_wrap_id), notice: "Material updated"
    else
      render :edit
    end
  end

  def destroy
    @material = find_vehicle_wraps_material
    @material.destroy
    redirect_to vehicle_wrap_path(@material.vehicle_wrap_id), notice: "Material removed"
  end

  private

  def find_vehicle_wraps_material
    VehicleWraps::Material.find(params[:id])
  end

  def vehicle_wraps_material_params
    params.require(:vehicle_wraps_material).permit(:area, :product_id)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
