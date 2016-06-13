class My::UnpaidInvoicesController < ApplicationController
  def index
    @invoices = Invoice.unpaid.order(updated_at: :desc)
    @total = Invoice.unpaid.pluck(:amount, :vat).flatten.reduce(0, :+)
  end
end
