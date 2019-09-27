class BlogsController < ApplicationController
  before_action :authenticate_user!, only: %i{new create destroy}
  before_action :correct_user, only: %i{destroy}

  def new
    @blog = current_user.blogs.build
  end

  def index
    @blogs = Blog.all.sort_by_created.paginate page: params[:page], per_page: 6
    @categories = Category.all
  end

  def show
    @blog = Blog.find_by id: params[:id]
    @comments = @blog.comments.parent_comments.paginate page: params[:page], per_page: 5
    @category = @blog.category
    @categories = Category.all
  end

  def create
    @blog = current_user.blogs.build blog_params
    if @blog.save
      redirect_to blog_path id: @blog
    else
      redirect_to root_path
    end
  end

  def destroy
    if @blog.destroy
      redirect_to user_path id: @blog.user_id
    else
      flash[:danger] = t "blog.controller.fail"
      redirect_to user_path id: @blog.user_id
    end
  end

  private
  def blog_params
    params.require(:blog).permit :title, :content, :category_id
  end

  def correct_user
    @blog = current_user.blogs.find_by id: params[:id]
    redirect_to root_path if @blog.nil?
  end
end
