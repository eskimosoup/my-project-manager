# This controller is used for helpful actions (i.e. autocomplete)
class UtilitiesController < ApplicationController
  def autocomplete
    @results = params[:model].constantize.select(params[:field].to_sym, :id).name_search(params[:term]) if params[:model] && params[:term] && params[:field]
    render json: @results.collect { |x| { value: x.send(params[:field]), id: x.id } }
  rescue
    nil
  end
end
