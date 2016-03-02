class InvoiceDownloadsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_pdf }

      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  private

  def invoice
    @invoice = Invoice.friendly.find(params[:invoice_id])
  end

  def download
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
      type: "application/pdf",
      disposition: "inline"
    }
  end
end
