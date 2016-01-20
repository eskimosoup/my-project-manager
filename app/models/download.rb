require "render_anywhere"

class Download
  include RenderAnywhere

  def initialize(project, user)
    @project = project
    @user = user
    @colour = project.brand.colour if project.present? && project.brand.present?
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("tmp/download.pdf")
  end

  def filename
    "Project #{ project.id }.pdf"
  end

  def render_attributes
    {
      template: "downloads/pdf",
      layout: "download_pdf",
      locals: { project: @project, user: @user, colour: @colour }
    }
  end

  private

  attr_reader :project

  def as_html
    render render_attributes
  end
end
