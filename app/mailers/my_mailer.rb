class MyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mailer.project_finalised.subject
  #
  def project_finalised(project)
    @project = project
    brand = project.brand
    my_job_sheet = MyJobSheet.new(@project)
    attachments[my_job_sheet.filename] = File.read(my_job_sheet.to_pdf)
    mail to: brand.email, subject: "A project has been finalised"
  end
end
