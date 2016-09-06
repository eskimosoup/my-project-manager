class ProjectInvoicesController < ApplicationController
  def index
    @project = find_project
    @percentage_invoices = @project.percentage_invoices
    @amount_invoices = @project.amount_invoices
  end

  private

  def find_project
    Project.find(params[:project_id])
  end
end
