class QuoteStagesController < ApplicationController
  before_action :quote_stages

  def index
    @quote_stages = quote_stages
    @quote_stage_projects = quote_stage_projects

    @projects = projects
  end

  def show
    @quote_stages = quote_stages
    @quote_stage_projects = quote_stage_projects

    @quote_stage = find_quote_stage
    @projects = projects(@quote_stage.id)
  end

  private

  def find_quote_stage
    QuoteStage.find(params[:id])
  end

  def quote_stages
    QuoteStage.includes(:projects).ordered_by_chance
  end

  def quote_stage_projects
    quote_stage_projects = quote_stages
    quote_stage_projects = quote_stage_projects.where(projects: { brand_id: params[:brand_id] }) if params[:brand_id].present?
    quote_stage_projects
  end

  def projects(quote_stage_id = nil)
    projects = Project.quoted
    projects = quote_stage_id.present? ? projects.where(quote_stage_id: quote_stage_id) : projects.where.not(quote_stage_id: nil)
    projects = projects.where(brand_id: params[:brand_id]) if params[:brand_id].present?
    projects = projects.order(quote_stage_updated_at: :desc)
    projects.page(params[:page]).per(params[:per_page] || 15)
  end
end
