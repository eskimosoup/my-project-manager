PDFKit.configure do |config|
  config.verbose = Rails.env.development?
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
end
