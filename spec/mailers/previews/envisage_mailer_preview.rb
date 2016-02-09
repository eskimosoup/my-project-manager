# Preview all emails at http://localhost:3000/rails/mailers/envisage_mailer
class EnvisageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/envisage_mailer/project_confirmed
  def project_confirmed
    project = Project.first
    EnvisageMailer.project_confirmed(project)
  end

end
