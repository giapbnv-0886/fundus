class AttendancesController < ApplicationController
  before_action :logged_in_user
  before_action :get_event, only: %i{create destroy}

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
    params.permit(:user_id)
  end
end
