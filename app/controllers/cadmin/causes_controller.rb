class Cadmin::CausesController < Cadmin::BasesController
  before_action :get_cause, only: %i(edit destroy show update)
  after_action :create_activity_create, only: %i(create)
  after_action :create_activity_update, only: %i(update)
  after_action :create_activity_destroy, only: %i(destroy)
  def new
    @cause = Cause.new
    @cause.blogs.build
  end

  def index
    @causes = Cause.all
  end

  def show; end

  def create
    @cause = Cause.new cause_params
    if @cause.save
      redirect_to cadmin_cause_path @cause.id
    else
      redirect_to cadmin_causes_path
    end
  end

  def edit; end

  def update
    @cause = Cause.find_by id: params[:id]
    if @cause.update_attributes cause_params
      redirect_to cadmin_cause_path @cause.id
    else
      redirect_to cadmin_causes_path
    end
  end

  def destroy
    if @cause.destroy
      redirect_to cadmin_causes_path
    else
      redirect_to cadmin_causes_path
    end
  end

  private
  def cause_params
    params.require(:cause).permit :title, :detail, :end_time, :category_id, :user_id, :goal_money, blogs_attributes: [:id, :title, :content, :category_id, :_destroy]
  end

  def get_cause
    @cause = Cause.find_by id: params[:id]
     return if @cause
    redirect_to cadmin_causes_path
  end

  def get_user
    @user = @cause.user
  end

  def create_activity_create
      @cause.create_activity :create, owner: get_user
  end

  def create_activity_update
    @cause.create_activity :update, owner: current_user
  end

  def create_activity_destroy
    @cause.create_activity :destroy, owner: current_user
  end
end
