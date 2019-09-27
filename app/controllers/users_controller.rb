class UsersController < ApplicationController

  def index ;end

  def show
    @user = User.find_by id: params[:id] || current_user
    @blogs = @user.blogs.sort_by_created.paginate(page: params[:page], per_page: 5)
    @events = @user.events
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
