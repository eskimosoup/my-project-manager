class QuoteStagesController < ApplicationController
  before_action :quote_stages

  def index
    @quote_stage_projects = @quote_stages
    @quote_stage_projects = @quote_stages.where(projects: { brand_id: params[:brand_id] }) if params[:brand_id].present?
  end

  def show
    @quote_stage = @quote_stage_projects = find_quote_stage
    @quote_stage_projects = @quote_stages.where(id: @quote_stage.id, projects: { brand_id: params[:brand_id] }) if params[:brand_id].present?
  end

  private

  def find_quote_stage
    QuoteStage.find(params[:id])
  end

  def quote_stages
    @quote_stages = QuoteStage.includes(:projects).ordered_by_chance
  end
end
