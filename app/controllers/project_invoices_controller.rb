class ProjectInvoicesController < ApplicationController
  def index
    @project = find_project
    @invoices = @project.invoices
  end

  private

  def find_project
    Project.find(params[:project_id])
  end
end
