class Customer::InvoicesController < ApplicationController
  skip_before_action :require_login
  layout "customer"

  def show
    @invoice = Invoice.friendly.find(params[:id])
  end
end
