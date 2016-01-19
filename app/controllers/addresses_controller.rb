class AddressesController < ApplicationController

  before_action :set_customer, only: [:new, :create]
  before_action :set_address, only: [:edit, :update, :destroy]

  def new
    @address = @customer.addresses.new
  end

  def create
    @address = @customer.addresses.new(address_params)
    if @address.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to @address.customer
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to @address.customer
  end

  private

  def address_params
    params.require(:address).permit(:name, :line_1, :line_2, :line_3,
                                    :city, :postcode, customer_ids: [])
  end

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
