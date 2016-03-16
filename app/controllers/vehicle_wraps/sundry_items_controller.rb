class VehicleWraps::SundryItemsController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @sundry_item = @vehicle_wrap.sundry_items.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @sundry_item = @vehicle_wrap.sundry_items.new(vehicle_wraps_sundry_item_params)
    if @sundry_item.save
      redirect_to @vehicle_wrap, notice: "SundryItem created"
    else
      render :new
    end
  end

  def edit
    @sundry_item = find_vehicle_wraps_sundry_item
  end

  def update
    @sundry_item = find_vehicle_wraps_sundry_item
    if @sundry_item.update(vehicle_wraps_sundry_item_params)
      redirect_to vehicle_wrap_path(@sundry_item.vehicle_wrap_id), notice: "SundryItem updated"
    else
      render :edit
    end
  end

  def destroy
    @sundry_item = find_vehicle_wraps_sundry_item
    @sundry_item.destroy
    redirect_to vehicle_wrap_path(@sundry_item.vehicle_wrap_id), notice: "SundryItem removed"
  end

  private

  def find_vehicle_wraps_sundry_item
    VehicleWraps::SundryItem.find(params[:id])
  end

  def vehicle_wraps_sundry_item_params
    params.require(:vehicle_wraps_sundry_item).permit(:cost, :name)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
