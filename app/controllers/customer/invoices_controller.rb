class Customer::InvoicesController < ApplicationController
  skip_before_action :require_login
  layout "customer"

  def show
    @invoice = Invoice.friendly.find(params[:id])
    redirect_to new_customer_invoice_payment_path(@invoice) unless @invoice.paid
  end
end
