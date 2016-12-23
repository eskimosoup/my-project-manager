class ProductItemsController < ApplicationController
  before_action :set_print_job, only: [:new, :create]
  before_action :set_product_item, only: [:edit, :update, :destroy]

  def new
    @product_item = ProductItem.new
  end

  def create
    @product_item = @print_job.product_items.new(product_item_params)
    if @product_item.save
      Discount.where(id: @print_job.discount_ids).delete_all
      redirect_to @print_job, notice: 'Added product successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @updated = @product_item.update(product_item_params)

    respond_to do |format|
      format.html do
        if @updated
          redirect_to @product_item.print_job, notice: 'Product updated successfully'
        else
          render :edit
        end
      end

      format.js { render :update }
    end
  end

  def destroy
    @product_item.destroy
    redirect_to @product_item.print_job, notice: 'Product removed successfully'
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def set_product_item
    @product_item = ProductItem.find(params[:id])
  end

  def product_item_params
    params.require(:product_item).permit(
      :area, :product_id, :actual_area, :actual_cost
    )
  end
end
