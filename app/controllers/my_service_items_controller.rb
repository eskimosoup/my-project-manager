class MyServiceItemsController < ApplicationController
  def new
    @print_job = find_print_job
    @my_service_item = @print_job.my_service_items.new
  end

  def create
    @print_job = find_print_job
    @my_service_item = @print_job.my_service_items.new(my_service_item_params)
    if @my_service_item.save
      redirect_to @print_job
    else
      render :new
    end
  end

  def edit
    @my_service_item = find_my_service_item
  end

  def update
    @my_service_item = find_my_service_item
    @updated = @my_service_item.update(my_service_item_params)

    respond_to do |format|
      format.html do
        if @updated
          redirect_to print_job_path(@my_service_item.print_job_id)
        else
          render :edit
        end
      end

      format.js { render :update }
    end
  end

  def destroy
    @my_service_item = find_my_service_item
    @my_service_item.destroy
    redirect_to print_job_path(@my_service_item.print_job_id)
  end

  private

  def find_print_job
    PrintJob.find(params[:print_job_id])
  end

  def find_my_service_item
    MyServiceItem.find(params[:id])
  end

  def my_service_item_params
    params.require(:my_service_item).permit(
      :name, :cost, :actual_cost
    )
  end
end
