class My::PaidInvoicesController < ApplicationController
  def index
    @invoices = Invoice.paid.order(updated_at: :desc).page(params[:page]).per(10)
  end
end
