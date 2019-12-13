class CausesController < ApplicationController
  before_action :authenticate_user!, only: %i{new create destroy}
  before_action :get_cause, only: %i(show)
  before_action :correct_user, only: %i{destroy}
  before_action :get_cause, only: %i(show edit)
  before_action :get_category, only: %i(index show)
  after_action :create_activity_create, only: %i(create)

  def new
    @cause = current_user.causes.build
  end

  def index
    @search = Cause.ransack( params[:q])
    @causes = @search.result.sort_by_created.paginate page: params[:page], per_page: 6
  end

  def show
  end

  def create
    @cause = current_user.causes.build cause_params
    if @cause.save
      redirect_to @cause
    else
      flash[:danger] = @cause.errors.message
      redirect_to root_path
    end
  end

  private
  def cause_params
    params.require(:cause).permit :title, :category_id, :end_time, :detail, :goal_money
  end

  def get_cause
    @cause = Cause.find_by_slug(params[:id]) || Cause.find_by(id: params[:id])
    return if @cause
    redirect_to root_path
  end

  def get_category
    @categories = Category.all
  end

  def create_activity_create
      @cause.create_activity :create, owner: current_user
  end
end
