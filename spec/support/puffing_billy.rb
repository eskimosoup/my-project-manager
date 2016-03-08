require 'billy/rspec'

RSpec.configure do |config|
  config.before :each, billy: true do
    Capybara.current_driver = :webkit_billy
    Capybara.javascript_driver = :webkit_billy
  end

  config.after do
    Capybara.javascript_driver = :webkit # or whatever you are using
  end
end
