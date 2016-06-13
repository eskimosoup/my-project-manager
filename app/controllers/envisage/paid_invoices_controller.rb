class Envisage::PaidInvoicesController < ApplicationController
  def index
    @invoices = Envisage::Invoice.paid.order_by_latest.page(params[:page]).per(10)
    @total = Envisage::Invoice.paid.pluck(:amount, :vat).flatten.reduce(0, :+)
    render template: "envisage/invoices/index"
  end
end
