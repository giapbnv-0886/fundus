class TagsController < ApplicationController
  def show
    @tag = Tag.find_by name: params[:name]
    if @tag
      @blogs = @tag.blogs
      @events = @tag.events
      @causes = @tag.causes
    else
      render "static_pages/404"
    end

  end

end
