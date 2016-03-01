class ProjectInvoicesController < ApplicationController
  def index
    @project = find_project
    @invoices = @project.invoices
  end

  def new
    @project = find_project
    @invoice_creator = InvoiceCreator.new(project: @project)
  end

  def edit
    @project = find_project
    @invoice_creator = InvoiceCreator.new(project: @project, attributes: invoice_params)
  end

  private

  def invoice_params
  end

  def find_project
    Project.find(params[:project_id])
  end
end
