class ActualCostsController < ApplicationController
  def index
    @print_job = print_job
    redirect_to print_job_path(@print_job), notice: 'Actual costs can not be recorded until this project is finalised' unless @print_job.finalised?
  end

  private

  def print_job
    PrintJob.find(params[:print_job_id])
  end
end
