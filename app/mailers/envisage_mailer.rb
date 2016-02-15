class EnvisageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.envisage_mailer.project_confirmed.subject
  #
  def project_confirmed(project)
    @project = project
    @billing_address = project.billing_address
    @shipping_address = project.shipping_address

    mail to: "to@example.org"
  end

  def project_finalised(project)
    @project = project
    envisage_job_sheet = EnvisageJobSheet.new(@project)
    attachments[envisage_job_sheet.filename] = File.read(envisage_job_sheet.to_pdf)
    mail to: "james@optimised.today"
  end
end
