class UsersController < ApplicationController

  def index ;end

  def show
    @user = User.find_by id: params[:id] || current_user
    @blogs = @user.blogs.sort_by_created.paginate page: params[:page], per_page: 5
    @events = @user.events.sort_by_created.paginate page: params[:page], per_page: 5
    @causes = @user.causes.sort_by_created.paginate page: params[:page], per_page: 5
  end
end
