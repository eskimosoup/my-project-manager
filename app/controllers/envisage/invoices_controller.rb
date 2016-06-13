class Envisage::InvoicesController < ApplicationController

  def index
    @invoices = Envisage::Invoice.order_by_latest.page(params[:page]).per(10)
    @total = Envisage::Invoice.pluck(:amount, :vat).flatten.reduce(0, :+)
  end

  def update
    envisage_invoice = find_envisage_invoice
    envisage_invoice.update(envisage_invoice_params)
    redirect_to project_path(envisage_invoice.project_id), notice: "Invoice marked as paid"
  end

  private

  def find_envisage_invoice
    Envisage::Invoice.find(params[:id])
  end

  def envisage_invoice_params
    params.require(:envisage_invoice).permit(:paid)
  end
end
