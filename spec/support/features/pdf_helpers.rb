module Features
  def content_type
    response_headers["Content-Type"]
  end

  def content_disposition
    response_headers["Content-Disposition"]
  end

  def download_filename
    content_disposition.scan(/filename="(.*)"/).last.first
  end

  def pdf_body
    temp_pdf = Tempfile.new('pdf')
    temp_pdf << page.source.force_encoding('UTF-8')
    reader = PDF::Reader.new(temp_pdf)
    reader.pages.first.text
  end
end
