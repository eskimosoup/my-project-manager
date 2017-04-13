require 'render_anywhere'

class InvoiceDownload
  include RenderAnywhere

  def initialize(invoice, envisage_invoice = false, template_file = nil)
    @invoice = invoice
    @envisage_invoice = envisage_invoice
    @project = invoice.project
    @colour = (envisage_invoice == false ? project.colour : '#56331a')
    @template_file = template_file
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file('tmp/invoice_download.pdf')
  end

  def filename
    @envisage_invoice == false ? "MY#{invoice.id + 500}.pdf" : "ENVS#{invoice.id}.pdf"
  end

  def render_attributes
    {
      template: template_file,
      layout: 'pdf',
      locals: { project: project, invoice: invoice, colour: colour }
    }
  end

  def template_file
    return @template_file if @template_file.present?
    @envisage_invoice == false ? 'invoices/pdf' : 'invoices/envisage_pdf'
  end

  private

  attr_reader :project, :invoice, :colour

  def as_html
    render render_attributes
  end
end
