class Envisage::UnpaidInvoicesController < ApplicationController
  def index
    @invoices = Envisage::Invoice.unpaid.order_by_latest.page(params[:page]).per(10)
    render template: "envisage/invoices/index"
  end
end
