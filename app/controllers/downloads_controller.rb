class DownloadsController < ApplicationController
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

  def download
    Download.new(project, current_user)
  end

  def send_pdf
    send_file download.to_pdf, download_attributes
  end

  def render_sample_html
    render download.render_attributes
  end

  def download_attributes
    {
      filename: download.filename,
      type: "application/pdf",
      disposition: "inline"
    }
  end
end
