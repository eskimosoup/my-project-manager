class VehicleWraps::LaboursController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @labour = @vehicle_wrap.labours.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @labour = @vehicle_wrap.labours.new(vehicle_wraps_labour_params)
    if @labour.save
      redirect_to @vehicle_wrap, notice: "Labour created"
    else
      render :new
    end
  end

  def edit
    @labour = find_vehicle_wraps_labour
  end

  def update
    @labour = find_vehicle_wraps_labour
    if @labour.update(vehicle_wraps_labour_params)
      redirect_to vehicle_wrap_path(@labour.vehicle_wrap_id), notice: "Labour updated"
    else
      render :edit
    end
  end

  def destroy
    @labour = find_vehicle_wraps_labour
    @labour.destroy
    redirect_to vehicle_wrap_path(@labour.vehicle_wrap_id), notice: "Labour removed"
  end

  private

  def find_vehicle_wraps_labour
    VehicleWraps::Labour.find(params[:id])
  end

  def vehicle_wraps_labour_params
    params.require(:vehicle_wraps_labour).permit(:hours, :labour_id)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
