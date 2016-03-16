class VehicleWraps::AccountManagementsController < ApplicationController
  def new
    @vehicle_wrap = find_vehicle_wrap
    @account_management = @vehicle_wrap.account_managements.new
  end

  def create
    @vehicle_wrap = find_vehicle_wrap
    @account_management = @vehicle_wrap.account_managements.new(vehicle_wraps_account_management_params)
    if @account_management.save
      redirect_to @vehicle_wrap, notice: "Account Management created"
    else
      render :new
    end
  end

  def edit
    @account_management = find_vehicle_wraps_account_management
  end

  def update
    @account_management = find_vehicle_wraps_account_management
    if @account_management.update(vehicle_wraps_account_management_params)
      redirect_to vehicle_wrap_path(@account_management.vehicle_wrap_id), notice: "Account Management updated"
    else
      render :edit
    end
  end

  def destroy
    @account_management = find_vehicle_wraps_account_management
    @account_management.destroy
    redirect_to vehicle_wrap_path(@account_management.vehicle_wrap_id), notice: "Account Management removed"
  end

  private

  def find_vehicle_wraps_account_management
    VehicleWraps::AccountManagement.find(params[:id])
  end

  def vehicle_wraps_account_management_params
    params.require(:vehicle_wraps_account_management).permit(:hours)
  end

  def find_vehicle_wrap
    VehicleWrap.find(params[:vehicle_wrap_id])
  end
end
