class MyPrintServicesItemsController < ApplicationController
  def new
    @print_job = find_print_job
    @my_print_services_item = @print_job.my_print_services_items.new
  end

  def create
    @print_job = find_print_job
    @my_print_services_item = @print_job.my_print_services_items.new(my_print_services_item_params)
    if @my_print_services_item.save
      redirect_to @print_job
    else
      render :new
    end
  end

  def edit
    @my_print_services_item = find_my_print_services_item
  end

  def update
    @my_print_services_item = find_my_print_services_item
    if @my_print_services_item.update(my_print_services_item_params)
      redirect_to print_job_path(@my_print_services_item.print_job_id)
    else
      render :edit
    end
  end

  def destroy
    @my_print_services_item = find_my_print_services_item
    @my_print_services_item.destroy
    redirect_to print_job_path(@my_print_services_item.print_job_id)
  end

  private

  def find_print_job
    PrintJob.find(params[:print_job_id])
  end

  def find_my_print_services_item
    MyPrintServicesItem.find(params[:id])
  end
  
  def my_print_services_item_params
    params.require(:my_print_services_item).permit(:name, :cost)
  end
end
