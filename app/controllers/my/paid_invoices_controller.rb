class My::PaidInvoicesController < ApplicationController
  def index
    @invoices = Invoice.paid.order(updated_at: :desc).page(params[:page]).per(50)
    @total = Invoice.paid.pluck(:amount, :vat).flatten.reduce(0, :+)
    @invoice_search = InvoiceSearch.new
    render "my/invoices/index"
  end
end
