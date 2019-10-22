class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: %i(about)

  def about; end

  def contact; end

  def help; end

  def index
    @blogs = Blog.all.sort_by_created.recent_post.paginate page: params[:page], per_page: 6
    @events = Event.all.sort_by_created.recent_post.paginate page: params[:page], per_page: 6
    @causes = Cause.all.sort_by_created.recent_post.paginate page: params[:page], per_page: 6
  end

  def search
    @causes = Cause.ransack(title_cont: params[:q]).result distinct: true
    @events = Event.ransack(title_cont: params[:q]).result distinct: true
    @blogs = Blog.ransack(title_cont: params[:q]).result distinct: true
    respond_to do |format|
      format.html{
        @causes.paginate page: params[:page], per_page: 6
        @events.paginate page: params[:page], per_page: 6
        @blogs.paginate page: params[:page], per_page: 6
      }
      format.json{
        @causes.limit 5
        @events.limit 5
        @blogs.limit 5
      }
    end
  end
end
