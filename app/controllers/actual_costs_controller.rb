class ActualCostsController < ApplicationController
  def index
    @print_job = print_job
  end

  private

  def print_job
    PrintJob.find(params[:print_job_id])
  end
end
