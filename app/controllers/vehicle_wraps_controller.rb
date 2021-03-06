class VehicleWrapsController < ApplicationController
  def index
    @vehicle_wraps = VehicleWrap.includes(:vehicle_type).page(params[:page]).per(10)
  end

  def new
    @vehicle_wrap = VehicleWrap.new
  end

  def create
    @vehicle_wrap = VehicleWrap.new(vehicle_wrap_params)
    if @vehicle_wrap.save
      redirect_to @vehicle_wrap, notice: 'Vehicle Wrap created'
    else
      render :new
    end
  end

  def edit
    @vehicle_wrap = find_vehicle_wrap
  end

  def update
    @vehicle_wrap = find_vehicle_wrap
    if @vehicle_wrap.update(vehicle_wrap_params)
      redirect_to @vehicle_wrap, notice: 'Vehicle Wrap updated'
    else
      render :edit
    end
  end

  def show
    @vehicle_wrap = find_vehicle_wrap
  end

  def destroy
    @vehicle_wrap = find_vehicle_wrap
    @vehicle_wrap.destroy
    redirect_to vehicle_wraps_url, notice: 'Vehicle wrap was successfully destroyed.'
  end

  private

  def find_vehicle_wrap
    VehicleWrap.find(params[:id])
  end

  def vehicle_wrap_params
    params.require(:vehicle_wrap).permit(:name, :description, :vehicle_type_id, :envisage_override_price, :envisage_trade_override_price, :envisage_to_my_override_price, :my_override_price)
  end
end
