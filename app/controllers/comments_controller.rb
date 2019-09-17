class CommentsController < ApplicationController

  before_action :get_blog, :get_comments, only: %i(create)
  before_action :get_blog_destroy, only: %i{destroy}
  before_action :get_comments, only: %i{create destroy}

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.html { redirect_to blog_path id: @blog }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to blog_path id: @blog }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  private
  def comment_params
    (params.require(:comment).permit(:content)).merge({blog_id: params[:blog_id]})
  end

  def get_blog
    @blog = Blog.find_by id: params[:blog_id]
    return if @blog
    redirect_to root_path
  end

  def get_comments

    @comments = @blog.comments.paginate page: params[:page], per_page: 5
  end

  def get_blog_destroy
    @comment = Comment.find_by id: params[:id]
    idd = @comment.blog_id
    @blog = Blog.find_by id: idd
    return if @blog
    redirect_to root_path
  end
end
