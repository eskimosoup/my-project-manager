class ArchiversController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    redirect_to @project unless @project.quoted?

    @project.archived!
    redirect_to @project, notice: "Project successfully archived"
  end

end
