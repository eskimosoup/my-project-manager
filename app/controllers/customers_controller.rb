class CustomersController < ApplicationController

  def index
    @customers = Customer.filter(params.slice(:name_search, :project_type)).page(params[:page]).per(params[:per_page] || 15)
  end

  def show
    @customer = find_customer
  end

  def edit
    @customer = find_customer
  end

  def update
    @customer = find_customer
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer successfully updated"
    else
      render :edit
    end
  end 

  private

  def find_customer
    Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :credit_limit)
  end
end
