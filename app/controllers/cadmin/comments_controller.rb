class Cadmin::CommentsController < Cadmin::BasesController
  before_action :get_comment, only: %i(edit destroy show update)

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def show; end

  def create
    @comment = Comment.new comment_params
    if @comment.save
      redirect_to cadmin_comment_path @comment.id
    else
      redirect_to cadmin_comments_path
    end
  end

  def edit; end

  def update
    if @comment.update_attributes comment_params
      redirect_to cadmin_comment_path @comment.id
    else
      redirect_to cadmin_comments_path
    end
  end

  def destroy
    if @comment.destroy
      redirect_to cadmin_comments_path
    else
      redirect_to cadmin_comment_path @comment.id
    end
  end

  private
  def get_comment
    @comment = Comment.find_by id: params[:id]
    redirect_to cadmin_comments_path unless @comment
  end

  def comment_params
    params.require(:comment).permit :content, :parent_id, :user_id, :blog_id
  end
end
