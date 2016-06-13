class Envisage::UnpaidInvoicesController < ApplicationController
  def index
    @invoices = Envisage::Invoice.unpaid.order_by_latest
    @total = Envisage::Invoice.unpaid.pluck(:amount, :vat).flatten.reduce(0, :+)
  end
end
