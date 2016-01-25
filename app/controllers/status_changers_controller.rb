class StatusChangersController < ApplicationController

  before_action :set_project

  def create
    status_changer = StatusChanger.klass_for(params[:status]).new(@project)
    if status_changer.save
      redirect_to @project, notice: "Status changed"
    else
      redirect_to @project, notice: "Could not change status"
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
