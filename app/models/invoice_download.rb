require 'render_anywhere'

class InvoiceDownload
  include RenderAnywhere

  def initialize(invoice)
    @invoice = invoice
    @project = invoice.project
    @colour = project.colour
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file('tmp/invoice_download.pdf')
  end

  def filename
    "MY#{invoice.id + 500}.pdf"
  end

  def render_attributes
    {
      template: 'invoices/pdf',
      layout: 'pdf',
      locals: { project: project, invoice: invoice, colour: colour }
    }
  end

  private

  attr_reader :project, :invoice, :colour

  def as_html
    render render_attributes
  end
end
