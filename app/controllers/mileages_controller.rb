class MileagesController < ApplicationController
  before_action :set_print_job, only: [:new, :create]
  before_action :set_mileage, except: [:new, :create]

  def new
    @mileage = Mileage.new
  end

  def create
    @mileage = @print_job.mileages.new(mileage_params)
    if @mileage.save
      Discount.where(id: @print_job.discount_ids).delete_all
      redirect_to @mileage.print_job, notice: "Mileage successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mileage.update(mileage_params)
      redirect_to @mileage.print_job, notice: "Mileage successully updated"
    else
      render :edit
    end
  end

  def destroy
    @mileage.destroy
    redirect_to @mileage.print_job, notice: "Mileage successfully destroyed"
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def set_mileage
    @mileage = Mileage.find(params[:id])
  end

  def mileage_params
    params.require(:mileage).permit(:miles)
  end
end
