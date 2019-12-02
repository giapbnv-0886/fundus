class Cadmin::BasesController < ApplicationController
  layout "cadmin"

  before_action :authenticate_user!
  before_action :user_admin

  def index; end

  private
  def user_admin
    return if current_user.role == "admin"
    flash[:danger] = t "cadmin.control.base.dan"
    redirect_to root_path
  end
end
