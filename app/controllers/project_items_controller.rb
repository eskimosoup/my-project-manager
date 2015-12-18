class ProjectItemsController < ApplicationController

  before_action :set_project, only: [:new, :create]

  def new
    @project_item = @project.project_items.new
  end

  def create
    @project_item = @project.project_items.new(project_item_params)
    if @project_item.save
      redirect_to @project, notice: "Product added to project"
    else
      render :new
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_item_params
    params.require(:project_item).permit(:size, :description, :product_id)
  end
end
