Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
  config.allow_url("https://js.stripe.com/v2/")
  config.ignore_ssl_errors
end
