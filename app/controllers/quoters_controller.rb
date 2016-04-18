class QuotersController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    redirect_to @project unless @project.archived?

    @project.quoted!
    redirect_to @project, notice: "Project successfully quoted"
  end

end
