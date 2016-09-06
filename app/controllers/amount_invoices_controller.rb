class AmountInvoicesController < ApplicationController
  def new
    @project = find_project
    @amount_invoice_creator = AmountInvoiceCreator.new(project_id: @project.id)
  end

  def create
    @project = find_project
    @amount_invoice_creator = AmountInvoiceCreator.new(invoice_params)
    if @amount_invoice_creator.save
      InvoiceMailer.invoice_created(@project, @amount_invoice_creator.amount_invoice).deliver_now
      redirect_to project_invoices_path(@amount_invoice_creator.project), notice: 'Invoice Created'
    else
      render :new
    end
  end

  private

  def invoice_params
    params.require(:amount_invoice_creator).permit(
      :name, :days_to_pay, :vat_items_description, :vat_items_total,
      :non_vat_items_description, :non_vat_items_total
    ).merge(project_id: find_project.id)
  end

  def find_project
    Project.find(params[:project_id])
  end
end
