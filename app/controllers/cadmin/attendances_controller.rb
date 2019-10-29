class Cadmin::AttendancesController < Cadmin::BasesController
  before_action :get_attendance, only: %i(show edit destroy update)
  def index
    @attendances =  Attendance.all
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.find_or_create_by attendane_params
    if @attendance
      redirect_to cadmin_attendance_path @attendance.id
    else
      redirect_to cadmin_attendances_path
    end
  end

  def show; end

  def edit; end

  def update
    @attendance = Attendance.update_attributes attendane_params
    if @attendance
      redirect_to cadmin_attendance_path @attendance.id
    else
      redirect_to cadmin_attendances_path
    end
  end

  def destroy
    if @attendance.destroy
      redirect_to cadmin_attendances_path
    else
      redirect_to cadmin_attendance_path @attendance.id
    end
  end

  private
  def get_attendance
    @attendance = Attendance.find_by id: params[:id]
    redirect_to cadmin_attendances_path unless @attendance
  end

  def attendane_params
    params.require(:attendance).permit :user_id, :event_id
  end
end
