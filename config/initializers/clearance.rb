Clearance.configure do |config|
  config.mailer_sender = "reply@example.com"
  config.routes = false
end

Clearance::PasswordsController.layout 'sessions'
Clearance::SessionsController.layout 'sessions'
Clearance::UsersController.layout 'sessions'
