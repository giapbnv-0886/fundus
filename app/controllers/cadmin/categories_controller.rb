class Cadmin::CategoriesController < Cadmin::BasesController
  before_action :get_category, only: %i(show edit destroy update)
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show; end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to cadmin_category_path @category
    else
      redirect_to cadmin_categories_path
    end
  end

  def destroy
    if @category.destroy
      redirect_to cadmin_categorys_path
    else
      redirect_to cadmin_category_path @category
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      redirect_to cadmin_category_path @category.id
    else
      redirect_to cadmin_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def get_category
    @category = Category.find_by id: params[:id]
    redirect_to cadmin_categories_path unless  @category
  end
end
