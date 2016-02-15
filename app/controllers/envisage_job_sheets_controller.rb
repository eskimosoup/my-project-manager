class EnvisageJobSheetsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_pdf }

      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  private

  def project
    @project = Project.find(params[:project_id])
  end

  def job_sheet
    EnvisageJobSheet.new(project)
  end

  def send_pdf
    send_file job_sheet.to_pdf, job_sheet_attributes
  end

  def render_sample_html
    render job_sheet.render_attributes
  end

  def job_sheet_attributes
    {
      filename: job_sheet.filename,
      type: "application/pdf",
      disposition: "inline"
    }
  end
end
