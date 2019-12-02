class Cadmin::EventsController < Cadmin::BasesController
  before_action :get_event, only: %i(edit destroy show update)

  def new
    @event = Event.new
  end
  def index
    @events = Event.all
  end

  def show; end
  def create
    @event = Event.new event_params
    if @event.save
      redirect_to cadmin_event_path @event.id
    else
      redirect_to cadmin_events_path
    end
  end

  def edit; end

  def update
    if @event.update_attributes event_params
      flash[:success] = "success"
      redirect_to cadmin_event_path @event.id
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find_by id: params[:id]
    if @event.destroy
      redirect_to cadmin_events_path
    else
      redirect_to cadmin_event_path @event
    end
  end

  private
  def event_params
    params.require(:event).permit :title, :category_id, :place, :content, :start_time, :end_time, :expiration_date, :cause_id
  end

  def get_event
    @event = Event.find_by id: params[:id]
    redirect_to cadmin_events_path unless @event
  end
end
