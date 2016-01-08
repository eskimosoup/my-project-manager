class DesignsController < ApplicationController
  before_action :set_print_job, only: [:new, :create]
  before_action :set_design, except: [:new, :create]

  def new
    @design = Design.new
  end

  def create
    @design = @print_job.designs.new(design_params)
    if @design.save
      redirect_to @print_job, notice: "Design successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @design.update(design_params)
      redirect_to @design.print_job, notice: "Design successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @design.destroy
    redirect_to @design.print_job, notice: "Design successfully destroyed"
  end

  private

  def set_print_job
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def set_design
    @design = Design.find(params[:id])
  end

  def design_params
    params.require(:design).permit(:hours)
  end
end
