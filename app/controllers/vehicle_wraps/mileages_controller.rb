class VehicleWraps::MileagesController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @mileage = @vehicle_wrap.mileages.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @mileage = @vehicle_wrap.mileages.new(vehicle_wraps_mileage_params)
    if @mileage.save
      redirect_to @vehicle_wrap, notice: "Mileage created"
    else
      render :new
    end
  end

  def edit
    @mileage = find_vehicle_wraps_mileage
  end

  def update
    @mileage = find_vehicle_wraps_mileage
    if @mileage.update(vehicle_wraps_mileage_params)
      redirect_to vehicle_wrap_path(@mileage.vehicle_wrap_id), notice: "Mileage updated"
    else
      render :edit
    end
  end

  def destroy
    @mileage = find_vehicle_wraps_mileage
    @mileage.destroy
    redirect_to vehicle_wrap_path(@mileage.vehicle_wrap_id), notice: "Mileage removed"
  end

  private

  def find_vehicle_wraps_mileage
    VehicleWraps::Mileage.find(params[:id])
  end

  def vehicle_wraps_mileage_params
    params.require(:vehicle_wraps_mileage).permit(:miles)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
