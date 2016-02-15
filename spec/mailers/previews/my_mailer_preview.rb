# Preview all emails at http://localhost:3000/rails/mailers/my_mailer
class MyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/my_mailer/project_finalised
  def project_finalised
    MyMailer.project_finalised
  end

end
