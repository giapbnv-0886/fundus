class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i{create destroy}
  before_action :correct_user, only: %i{destroy}

  def new
    @event = Event.new
  end

  def index
    @events = Event.sort_by_created.paginate(page: params[:page], per_page: 6)
  end

  def show
    @event = Event.find_by id: params[:id]
  end

  def create
    @event = current_user.events.build event_params

    if @event.save
      redirect_to event_path  @event
    else
      redirect_to root_path
    end
  end

  def destroy
    if @event.destroy
      redirect_to user_path id: @event.user_id
    else
      redirect_to user_path id: @event.user_id
    end
  end

  def attendancing
  end

  private
  def event_params
    params.require(:event).permit(:title, :category_id, :place, :start_time, :end_time, :content, :expiration_date).merge({user_id: params[:user_id]})
  end

  def correct_user
    @event = current_user.events.find_by id: params[:id]
    redirect_to root_path if @event.nil?
  end
end
