class Causes::AmountPerMonthsController < ApplicationController
  before_action :get_cause, only: %i(show)

  def show
   render json: @cause.amount_per_month.chart_json
  end

  private
  def get_cause
    @cause = Cause.find_by_slug(params[:cause_id])||Cause.find_by(id: params[:cause_id])
    redirect_to  root_path unless @cause
  end
end
