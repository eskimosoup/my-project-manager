class EnvisageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.envisage_mailer.project_confirmed.subject
  #
  def project_confirmed(project)
    @project = project
    brand = project.brand
    @billing_address = project.billing_address
    @shipping_address = project.shipping_address

    # mail to: "talkprint@envisageprint.co.uk", subject: "A project has been confirmed"
    mail to: "purchasing@wearemy.co.uk", subject: "A project has been confirmed"
  end

  def project_finalised(project)
    @project = project
    brand = project.brand
    envisage_job_sheet = EnvisageJobSheet.new(@project)
    attachments[envisage_job_sheet.filename] = File.read(envisage_job_sheet.to_pdf)
    #mail to: "talkprint@envisageprint.co.uk", subject: "A project has been finalised"
    mail to: "purchasing@wearemy.co.uk", subject: "A project has been finalised"
  end
end
