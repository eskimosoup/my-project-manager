class MultipleProductAdditionsController < ApplicationController
  before_action :set_print_job

  def new
    @multiple_product_addition = MultipleProductAddition.new(print_job_id: @print_job.id)
  end

  def create
    @multiple_product_addition = MultipleProductAddition.new(multiple_product_addition_params)
    if @multiple_product_addition.save
      redirect_to @multiple_product_addition.print_job
    else
      render :new
    end
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def multiple_product_addition_params
    product_params = params.require(:multiple_product_addition).permit(product_items_attributes: [
    :product_id, :area, :print_job_id])
    product_params.merge!(ActionController::Parameters.new(print_job_id: params[:print_job_id]))
  end
end
