class ProjectSearchesController < ApplicationController
  def quoted_only
    @project_search = ProjectSearch.new(quoted: 1)
    @projects = @project_search.results.page(params[:page]).per(@project_search.per_page)
    render 'projects/index'
  end

  def sold_and_finalised
    @project_search = ProjectSearch.new(sold: 1, finalised: 1)
    @projects = @project_search.results.page(params[:page]).per(@project_search.per_page)
    render 'projects/index'
  end

  def show
    @project_search = ProjectSearch.new(project_search_params)
    @projects = @project_search.results.page(params[:page]).per(@project_search.per_page)
    render 'projects/index'
  end

  def create
    redirect_to project_search_path(project_search: project_search_params)
  end

  private

  def project_search_params
    params.require(:project_search).permit!
  end
end
