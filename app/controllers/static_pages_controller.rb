class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: %i(about)

  def about; end

  def contact; end

  def help; end

  def index
    @blogs = Blog.all.sort_by_created.recent_post
    @events = Event.all.sort_by_created.recent_post
    @causes = Cause.all.sort_by_created.recent_post
  end
end
