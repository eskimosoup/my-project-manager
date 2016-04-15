PDFKit.configure do |config|
  if Rails.env.production?
    config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  else
    config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  end
end
