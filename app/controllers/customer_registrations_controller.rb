class CustomerRegistrationsController < ApplicationController

  def new
    @customer_registration = CustomerRegistration.new
  end

  def create
    @customer_registration = CustomerRegistration.new(customer_registration_params)
    if @customer_registration.save
      redirect_to @customer_registration.customer, notice: "Customer was successfully registered"
    else
      render :new
    end
  end

  private

  def customer_registration_params
    params.require(:customer_registration).permit(:customer_name, :customer_credit_limit,
                                                  :contact_name, :contact_email, :contact_phone,
                                                  :contact_role)
  end
end
