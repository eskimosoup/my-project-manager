class JobSpecificationsController < ApplicationController
  before_action :set_print_job, only: [:new, :create]
  before_action :set_job_specification, only: [:edit, :update, :destroy]

  def new
    @job_specification = JobSpecification.new
  end

  def create
    @job_specification = @print_job.job_specifications.new(job_specification_params)
    if @job_specification.save
      Discount.where(id: @print_job.discount_ids).delete_all
      redirect_to @print_job, notice: 'Job specification successfully added'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @updated = @job_specification.update(job_specification_params)

    respond_to do |format|
      format.html do
        if @updated
          redirect_to @job_specification.print_job, notice: 'Job specification successfully updated'
        else
          render :edit
        end
      end

      format.js { render :update }
    end
  end

  def destroy
    @job_specification.destroy
    redirect_to @job_specification.print_job, notice: 'Job specification successfully destroyed'
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def set_job_specification
    @job_specification = JobSpecification.find(params[:id])
  end

  def job_specification_params
    params.require(:job_specification).permit(
      :hours, :actual_hours
    )
  end
end
