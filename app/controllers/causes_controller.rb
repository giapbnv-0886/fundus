class CausesController < ApplicationController
  before_action :authenticate_user!, only: %i{create destroy}
  before_action :correct_user, only: %i{destroy}

  def new
    @cause = Cause.new
  end

  def index
    @causes = Cause.sort_by_created.paginate(page: params[:page], per_page: 6)
  end

  def show
    @cause = Cause.find_by id: params[:id]
    @categories = Category.all
  end

  def create
    @cause = current_user.causes.build cause_params

    if @cause.save
      redirect_to causes_path
    else
      redirect_to root_path
    end
  end

  private
  def cause_params
    params.require(:cause).permit(:title, :category_id, :end_time, :detail, :goal_money).merge({user_id: params[:user_id]})
  end
end
