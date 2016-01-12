class CustomersController < ApplicationController

  def index
    @customers = Customer.all
    @customers = @customers + @customers + @customers + @customers + @customers + @customers + @customers + @customers + @customers
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
