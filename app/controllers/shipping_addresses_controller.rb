class ShippingAddressesController < ApplicationController
  before_action :set_project, :set_addresses

  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      redirect_to @project
    else
      render :new
    end
  end
  
  def edit
    @shipping_address = ShippingAddress.new(shipping_address_params)
  end

  private

  def shipping_address_params
    default_params = ActionController::Parameters.new(project_id: @project.id, shipping_address_id: @project.shipping_address_id)
    default_params.merge!(user_params)
  end

  def user_params
    if params[:shipping_address]
      user_params = params.require(:shipping_address).permit(:shipping_address_id)
    else
      {}
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_addresses
    @addresses = Address.where(customer_id: @project.customer_id)
  end
end
