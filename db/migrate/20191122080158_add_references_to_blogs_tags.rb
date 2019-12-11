class AddReferencesToBlogsTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :blog, foreign_key: true
  end
end
