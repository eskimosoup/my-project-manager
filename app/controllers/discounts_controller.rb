class DiscountsController < ApplicationController
  def new
    @project = find_project
    @discount = @project.discounts.new
  end

  def create
    @project = find_project
    @discount = @project.discounts.new(discount_params)
    if @discount.save
      redirect_to @project, notice: "Discount applied"
    else
      render :new
    end
  end

  def destroy
    @discount = find_discount
    @discount.destroy
    redirect_to project_path(@discount.project_id), notice: "Discount removed"
  end

  private

  def discount_params
    params.require(:discount).permit(:percentage, :amount, :description)
  end

  def find_project
    Project.find(params[:project_id])
  end

  def find_discount
    Discount.find(params[:id])
  end
end
