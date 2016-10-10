class Envisage::InvoicesController < ApplicationController
  def index
    @invoices = Envisage::Invoice.order_by_latest.page(params[:page]).per(10)
    @total = Envisage::Invoice.pluck(:amount, :vat).flatten.reduce(0, :+)
  end

  def update
    envisage_invoice = find_envisage_invoice
    envisage_invoice.update(envisage_invoice_params)
    redirect_to project_path(envisage_invoice.project_id), notice: 'Invoice marked as paid'
  end

  def download_invoice
    respond_to do |format|
      format.pdf { send_pdf }

      format.html { render_sample_html } if Rails.env.development?
    end
  end

  private

  def find_envisage_invoice
    Envisage::Invoice.find(params[:id])
  end

  def envisage_invoice_params
    params.require(:envisage_invoice).permit(:paid)
  end

  def download
    invoice = find_envisage_invoice
    InvoiceDownload.new(invoice)
  end

  def send_pdf
    send_file download.to_pdf, download_attributes
  end

  def render_sample_html
    render download.render_attributes
  end

  def download_attributes
    {
      filename: download.filename,
      type: 'application/pdf',
      disposition: 'inline'
    }
  end
end
