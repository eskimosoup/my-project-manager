class SellersController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    status_changer = StatusChanger::Sold.new(@project)
    if status_changer.save
      redirect_to @project, notice: "Status changed"
    else
      redirect_to @project, notice: "Could not change status"
    end
  end
end
