class PrintJobsController < ApplicationController
  before_action :set_project, only: [:new, :create]
  before_action :set_print_job, except: [:new, :create]

  def new
    @print_job = PrintJob.new
  end

  def create
    @print_job = @project.print_jobs.new(print_job_params)
    if @print_job.save
      redirect_to @print_job, notice: "Print job successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @print_job.update(print_job_params)
      redirect_to @print_job, notice: "Print job successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @print_job.destroy
    redirect_to @print_job.project, notice: "Print job successfully destroyed"
  end

  def show
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
    @presented_project = presenter(@project)
  end

  def print_job_params
    params.require(:print_job).permit(:name)
  end

  def set_print_job
    @print_job = PrintJob.find(params[:id])
    @presented_print_job = presenter(@print_job)
    @presented_project = presenter(@print_job.project)
  end
end
