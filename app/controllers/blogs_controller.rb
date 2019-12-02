class BlogsController < ApplicationController
  before_action :authenticate_user!, only: %i{new create destroy}
  before_action :correct_blog, only: %i{destroy}
  before_action :get_cause, only: %i(new index create update)
  before_action :correct_cause, only:  %i(new create update)

  def new
    @blog = @cause.blogs.build
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def index
    @search = @cause.blogs.search(title_cont: params[:q])
    @blogs = @search.result.sort_by_created.paginate page: params[:page], per_page: 6
    @categories = Category.all
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def show
    @blog = Blog.find_by_slug(params[:id]) || Blog.find_by(id: params[:id])
    @comments = @blog.comments.parent_comments.paginate page: params[:page], per_page: 5
    @category = @blog.category
    @categories = Category.all
  end

  def create
    @blog = @cause.blogs.build blog_params
    if @blog.save
      flash[:success] = t "blog.notice.success"
      redirect_to blog_path @blog
    else
      flash[:danger] = @blog.errors.messages
      redirect_to root_path
    end
  end

  def destroy
    if @blog.destroy
      redirect_to user_path current_user
    else
      flash[:danger] = t "blog.controller.fail"
      redirect_to user_path current_user
    end
  end

  private
  def blog_params
    params.require(:blog).permit :title, :content, :category_id, :hash_tag
  end

  def get_cause
    @cause = Cause.find_by_slug(params[:cause_id]) || Cause.find_by(id: params[:cause_id])
    return if @cause
    flash[:danger] = t "cause.error.not_found"
    redirect_to causes_path
  end

  def correct_cause
    return if current_user&.causes.include? @cause
    flash[:warning] = t "blog.notice.not_permit"
    redirect_to @cause
  end

  def correct_blog
    @blog = Blog.find_by_slug(params[:id]) || Blog.find_by(id: params[:id])
    return if @blog.cause.user == current_user
    flash[:warning] = t "blog.notice.not_permit"
    redirect_to root_path
  end
end
