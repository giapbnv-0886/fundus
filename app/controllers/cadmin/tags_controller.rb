class Cadmin::TagsController < Cadmin::BasesController
  before_action :get_tag, only: %i(edit destroy show update)

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def show; end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      redirect_to cadmin_tag_path @tag
    else
      redirect_to cadmin_tags_path
    end
  end

  def destroy
    if @tag.destroy
      redirect_to cadmin_tags_path
    else
      redirect_to cadmin_tag_path @tag
    end
  end

  def edit; end

  def update
    if @tag.update_attributes tag_params
      redirect_to cadmin_tag_path @tag.id
    else
      redirect_to cadmin_tags_path
    end
  end

  private
  def tag_params
    params.require(:tag).permit :name
  end

  def get_tag
    @tag = Tag.find_by id: params[:id]
    redirect_to cadmin_tags_path unless @tag
  end

end
