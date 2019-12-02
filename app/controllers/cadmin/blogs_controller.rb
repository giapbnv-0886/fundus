class Cadmin::BlogsController < Cadmin::BasesController
  before_action :get_blog, only: %i(edit destroy show update)

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def show; end

  def create
    @blog = Blog.new blog_params
    if @blog.save
      redirect_to cadmin_blog_path @blog.id
    else
      redirect_to cadmin_blogs_path
    end
  end

  def edit; end

  def update
    if @blog.update_attributes blog_params
      redirect_to cadmin_blog_path @blog.id
    else
      redirect_to cadmin_blogs_path
    end
  end

  def destroy
    if @blog.destroy
      redirect_to cadmin_blogs_path
    else
      redirect_to cadmin_blog_path @tag
    end
  end

  private
  def get_blog
    @blog = Blog.find_by id: params[:id]
    redirect_to cadmin_blogs_path unless @blog
  end

  def blog_params
    params.require(:blog).permit :cause_id, :title, :content, :category_id, tag_ids:[]
  end
end
