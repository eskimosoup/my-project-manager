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
end
