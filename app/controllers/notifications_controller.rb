class NotificationsController < ApplicationController
  before_action :get_user, only: %i(index)

  def index
    @notifications = @user.notifications
    respond_to do |format|
      format.js {}
      format.html{}
    end
  end

  private
  def get_user
    @user = User.find_by id: params[:user_id]
    return if @user and @user == current_user
    flash[:danger] = t "user.notice.not_permit"
    redirect_to root_path
  end
end
