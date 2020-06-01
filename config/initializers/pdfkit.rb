PDFKit.configure do |config|
  config.verbose = Rails.env.development?
  config.wkhtmltopdf = if Rails.env.production?
                         '/usr/local/bin/wkhtmltopdf'
                       else
                         '/usr/bin/wkhtmltopdf'
                       end
end
