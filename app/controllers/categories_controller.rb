class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by id: params[:id]
    @blogs = @category.blogs.paginate page: params[:page], per_page: 5
    @events = @category.events.paginate page: params[:page], per_page: 5
    @causes = @category.causes.paginate page: params[:page], per_page: 5
    @categories = Category.all
  end
end
