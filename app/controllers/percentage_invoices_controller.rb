class PercentageInvoicesController < ApplicationController
  def new
    @project = find_project
    @percentage_invoice_creator = PercentageInvoiceCreator.new(project_id: @project.id)
  end

  def create
    @project = find_project
    @percentage_invoice_creator = PercentageInvoiceCreator.new(invoice_params)
    if @percentage_invoice_creator.save
      InvoiceMailer.invoice_created(@project, @percentage_invoice_creator.percentage_invoice).deliver_now
      redirect_to project_invoices_path(@percentage_invoice_creator.project), notice: 'Invoice Created'
    else
      render :new
    end
  end

  private

  def invoice_params
    params.require(:percentage_invoice_creator).permit(
      :percentage, :name, :days_to_pay).merge(project_id: find_project.id)
  end

  def find_project
    Project.find(params[:project_id])
  end
end
