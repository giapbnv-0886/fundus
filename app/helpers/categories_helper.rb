module CategoriesHelper
  def count_category category
    category.causes.count+category.blogs.count+category.events.count
  end
end
