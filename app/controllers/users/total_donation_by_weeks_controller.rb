class Users::TotalDonationByWeeksController < ApplicationController
  before_action :get_user, only: %i(show)

  def show
    render json: @user.total_amount_donated_by_week.chart_json
  end

  private
  def get_user
    @user = User.find_by id: params[:user_id]
    redirect_to root_path unless @user
  end
end
