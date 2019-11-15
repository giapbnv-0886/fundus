class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i{index show edit}
  before_action :correct_user, only: %i{destroy}
  before_action :get_event, :get_attendance, only: %i{show}
  before_action :get_category, only: %i(index show)
  before_action :get_cause, only: %i(index new create update)
  before_action :correct_cause, only: %i(create update)

  def new
    @event = @cause.events.build
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def index
    @search = @cause.events.search(params[:q])
    @events = @search.result.sort_by_created.paginate page: params[:page], per_page: 6
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def show
  end

  def create
    @event = @cause.events.build event_params
    if @event.save
      respond_to do |format|
        format.html{
          flash[:success] = t "event.notice.created"
          redirect_to event_path  @event
        }
        format.js{}
      end
    else
      respond_to do |format|
        format.html{
          flash[:danger] = @event.errors
          redirect_to get_cause
        }
        format.js{}
      end
    end
  end

  def destroy
    if @event.destroy
      redirect_to user_path id: @event.cause_id
    else
      redirect_to user_path id: @event.cause_id
    end
  end

  private
  def event_params
    params.require(:event).permit :title, :category_id, :place, :start_time, :end_time, :content, :expiration_date
  end

  def correct_user
    @event = current_user.events.find_by id: params[:id]
    redirect_to root_path if @event.nil?
  end

  def get_attendance
    @attendance = @event.attendances.find_by user_id: current_user.id if user_signed_in?
  end

  def get_event
    @event = Event.find_by_slug(params[:id]) ||Event.find_by(id: params[:id])
    return if @event
    redirect_to root_path
  end

  def get_category
    @categories = Category.all
  end

  def get_cause
    @cause = Cause.find_by_slug(params[:cause_id]) || Cause.find_by(id: params[:cause_id])
    return if @cause
    flash[:danger] = t "cause.error.not_found"
    redirect_to causes_path
  end

  def correct_cause
    return if @cause&.user == current_user
    flash[:warning] = t "cause.error.not_permit"
    redirect_to @cause
  end
end
