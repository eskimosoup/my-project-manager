class CustomersController < ApplicationController

  def index
    @customers = Customer.filter(params.slice(:name_search, :project_type)).page(params[:page]).per(params[:per_page] || 15)
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
