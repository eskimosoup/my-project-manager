class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    @project = find_project
  end

  def update
    @project = find_project
    @updated = @project.update(project_params)

    respond_to do |format|
      format.html do
        if @updated
          redirect_to @project, notice: 'Updated project'
        else
          render :edit
        end
      end

      format.js
    end
  end

  def index
    @project_search = ProjectSearch.new
    @projects = Project.page(params[:page]).per(params[:per_page] || 15).order(updated_at: :desc)
  end

  def show
    @project = find_project
    render template: "projects/#{@project.status}"
  end

  def destroy
    @project = find_project
    @project.destroy
    redirect_to projects_path, notice: 'Destroyed project'
  end

  private

  def project_params
    params.require(:project).permit(
      :name, :description, :brand_id, :customer_id, :delivery_deadline, :notes,
      :purchase_order, :quote_stage_id
    )
  end

  def find_project
    Project.find(params[:id])
  end
end
