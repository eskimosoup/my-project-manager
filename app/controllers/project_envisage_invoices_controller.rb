class ProjectEnvisageInvoicesController < ApplicationController
  def create
    @project = find_project
    @project.envisage_invoices.create(
      name: @project.name,
      amount: @project.envisage_to_my_price,
      vat: @project.envisage_to_my_vat,
      percentage: 100
    )
    redirect_to @project, notice: "Envisage invoice created"
  end

  private

  def find_project
    Project.find(params[:project_id])
  end
end
