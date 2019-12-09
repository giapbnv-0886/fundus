class Users::DonationByWeeksController < ApplicationController
  before_action :get_user, :get_category, only: %i(show)

  def show
    render json: @user.amount_donated_by_week_for(@category).chart_json
  end

  private
  def get_user
    @user = User.find_by id: params[:user_id]
    redirect_to root_path unless @user
  end

  def get_category
    @category = Category.find_by id: params[:category_id]
    redirect_to root_path unless @category
  end
end
