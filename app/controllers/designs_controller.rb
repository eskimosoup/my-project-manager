class DesignsController < ApplicationController
  before_action :set_project, only: [:new, :create]
  before_action :set_design, except: [:new, :create]

  def new
    @design = Design.new
  end

  def create
    @design = @project.designs.new(design_params)
    if @design.save
      redirect_to @project, notice: "Design successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @design.update(design_params)
      redirect_to @design.project, notice: "Design successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @design.destroy
    redirect_to @design.project, notice: "Design successfully destroyed"
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_design
    @design = Design.find(params[:id])
  end

  def design_params
    params.require(:design).permit(:hours)
  end
end
