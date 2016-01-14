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

  def index
    @projects = Project.filter(params.slice(:name_search, :customer_id, :project_type)).page(params[:page]).per(params[:per_page] || 15)
    @presented_projects = collection_presenter(@projects)
  end

  def show
    @project = Project.find(params[:id])
    @presented_project = presenter(@project)
    @presented_print_jobs = collection_presenter(@project.print_jobs, PrintJobPresenter) if @project.print_jobs.present?
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :brand_id, :customer_id)
  end
end
