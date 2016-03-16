class VehicleWraps::SupportingMaterialsController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @supporting_material = @vehicle_wrap.supporting_materials.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @supporting_material = @vehicle_wrap.supporting_materials.new(vehicle_wraps_supporting_material_params)
    if @supporting_material.save
      redirect_to @vehicle_wrap, notice: "Supporting Material created"
    else
      render :new
    end
  end

  def edit
    @supporting_material = find_vehicle_wraps_supporting_material
  end

  def update
    @supporting_material = find_vehicle_wraps_supporting_material
    if @supporting_material.update(vehicle_wraps_supporting_material_params)
      redirect_to vehicle_wrap_path(@supporting_material.vehicle_wrap_id), notice: "Supporting Material updated"
    else
      render :edit
    end
  end

  def destroy
    @supporting_material = find_vehicle_wraps_supporting_material
    @supporting_material.destroy
    redirect_to vehicle_wrap_path(@supporting_material.vehicle_wrap_id), notice: "Supporting Material removed"
  end

  private

  def find_vehicle_wraps_supporting_material
    VehicleWraps::SupportingMaterial.find(params[:id])
  end

  def vehicle_wraps_supporting_material_params
    params.require(:vehicle_wraps_supporting_material).permit(:area, :supporting_product_id)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end

end
