require "render_anywhere"

class EnvisageJobSheet
  include RenderAnywhere

  def initialize(project)
    @project = project
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("tmp/envisage_job_sheet.pdf")
  end

  def filename
    "Project #{ project.id } Envisage Job Sheet.pdf"
  end

  def render_attributes
    {
      template: "envisage_job_sheets/pdf",
      layout: "pdf",
      locals: { project: project }
    }
  end

  private

  attr_reader :project

  def as_html
    render render_attributes
  end

end
