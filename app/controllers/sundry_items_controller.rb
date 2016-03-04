class SundryItemsController < ApplicationController
  before_action :set_print_job, only: [:new, :create]
  before_action :set_sundry_item, only: [:edit, :update, :destroy]

  def new
    @sundry_item = SundryItem.new
  end

  def create
    @sundry_item = @print_job.sundry_items.new(sundry_item_params)
    if @sundry_item.save
      Discount.where(id: @print_job.discount_ids).delete_all
      redirect_to @print_job, notice: "Sundry item successfully added"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @sundry_item.update(sundry_item_params)
      redirect_to @sundry_item.print_job, notice: "Sundry item successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @sundry_item.destroy
    redirect_to @sundry_item.print_job, notice: "Sundry item successfully destroyed"
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def set_sundry_item
    @sundry_item = SundryItem.find(params[:id])
  end

  def sundry_item_params
    params.require(:sundry_item).permit(:name, :cost)
  end
end
