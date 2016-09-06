class InvoiceMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mailer.project_finalised.subject
  #
  def invoice_created(project, invoice)
    @project = project
    @invoice = invoice
    brand = project.brand
    invoice_pdf = InvoiceDownload.new(@invoice)
    attachments[invoice_pdf.filename] = File.read(invoice_pdf.to_pdf)
    if Rails.env.production?
      mail to: 'purchasing@ludostudio.co.uk', cc: 'george@optimised.today', subject: "Invoice #{@invoice.number} has been created for #{brand.name}"
    else
      mail to: 'support@optimised.today', subject: "Invoice #{@invoice.number} has been created for #{brand.name}"
    end
  end
end
