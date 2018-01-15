class InvoiceDownloadsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_pdf(full: true) }

      if Rails.env.development?
        format.html { render_sample_html(full: true) }
      end
    end
  end

  def summarised
    respond_to do |format|
      format.pdf { send_pdf(full: false) }

      if Rails.env.development?
        format.html { render_sample_html(full: false) }
      end
    end
  end

  private

  def invoice
    @invoice = Invoice.friendly.find(params[:invoice_id])
  end

  def full_download
    InvoiceDownload.new(invoice)
  end

  def summarised_download
    InvoiceDownload.new(invoice, false, 'invoices/summarised')
  end

  def download_type(full)
    full == true ? full_download : summarised_download
  end

  def send_pdf(full: true)
    download = download_type(full)
    send_file download.to_pdf, download_attributes(download)
  end

  def render_sample_html(full: true)
    download = download_type(full)
    render download.render_attributes
  end

  def download_attributes(download)
    {
      filename: download.filename,
      type: "application/pdf",
      disposition: "attachment"
    }
  end
end
