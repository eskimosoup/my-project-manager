class LabourItemsController < ApplicationController
  before_action :set_print_job, only: [:new, :create]
  before_action :set_labour_item, only: [:edit, :update, :destroy]

  def new
    @labour_item = LabourItem.new
  end

  def create
    @labour_item = @print_job.labour_items.new(labour_item_params)
    if @labour_item.save
      redirect_to @print_job, notice: "Labour item successfully added"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @labour_item.update(labour_item_params)
      redirect_to @labour_item.print_job, notice: "Labour item successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @labour_item.destroy
    redirect_to @labour_item.print_job, notice: "Labour item successfully destroyed"
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def labour_item_params
    params.require(:labour_item).permit(:hours, :labour_id)
  end

  def set_labour_item
    @labour_item = LabourItem.find(params[:id])
  end
end
