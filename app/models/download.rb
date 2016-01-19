require "render_anywhere"

class Download
  include RenderAnywhere

  def initialize(project)
    @project = project
  end

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_file("tmp/download.pdf")
  end

  def filename
    "Project #{ project.id }.pdf"
  end

  def render_attributes
    {
      template: "downloads/pdf",
      layout: "download_pdf",
      locals: { project: project }
    }
  end

  private

  attr_reader :project

  def as_html
    render render_attributes
  end
end
