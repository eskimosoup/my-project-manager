class My::UnpaidInvoicesController < ApplicationController
  def index
    @invoices = Invoice.unpaid.order(updated_at: :desc).page(params[:page]).per(10)
  end
end
