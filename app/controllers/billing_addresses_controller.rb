class BillingAddressesController < ApplicationController
  before_action :set_project, :set_addresses

  def new
    @billing_address = BillingAddress.new
  end

  def create
    @billing_address = BillingAddress.new(billing_address_params)
    if @billing_address.save
      redirect_to @project
    else
      render :new
    end
  end
  
  def edit
    @billing_address = BillingAddress.new(billing_address_params)
  end

  private

  def billing_address_params
    default_params = ActionController::Parameters.new(project_id: @project.id, billing_address_id: @project.billing_address_id)
    default_params.merge!(user_params)
  end

  def user_params
    if params[:billing_address]
      user_params = params.require(:billing_address).permit(:billing_address_id)
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
