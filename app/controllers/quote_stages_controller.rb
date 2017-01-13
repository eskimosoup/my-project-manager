class QuoteStagesController < ApplicationController
  def index
    @quote_stages = QuoteStage.includes(:projects).ordered_by_chance
    @quote_stages = @quote_stages.find_by(id: params[:quote_stage_id]) if params[:quote_stage_id].present?
  end
end
