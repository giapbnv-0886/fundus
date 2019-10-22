class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)
  before_action :logged_in_user
  before_action :get_event, only: %i{create destroy}
  before_action :get_object, :get_attributes, only: %i(index)

  def index
    csv = ExportCsv.new @object, @attributes
    respond_to do |format|
      format.csv { send_data csv.perform, filename: "#{t "attendaces.csv_name", title: @event.title}.csv" }
    end
  end

  def create
    @attendance = @event.active_attendances.build attendance_params
    if @attendance.save
      respond_to do |format|
        format.html { redirect_to @event }
        format.js
      end
    else
    redirect_to root_path
    end
  end

  def destroy
    if @event.unattend? current_user
      respond_to do |format|
        format.html { redirect_to @event }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  private
  def get_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    redirect_to events_path

  end

  def attendance_params
    params.permit :user_id
  end

  def get_object
    @event = Event.find_by id: params[:event_id]
    if @event
      @object = @event.active_attendances
    else
      flash[:danger] = t "cause.error.notfound"
      redirect_to events_path
    end
  end

  def get_attributes
    @attributes = Attendance::CSV_ATTRIBUTES
  end

  def correct_owner
    return if @event.belong? current_user
    flash[:danger] = t "cause.error.notfound"
    redirect_to events_path
  end
end
