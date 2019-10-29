class AddDeletedAtToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :deleted_at, :datetime
    add_index :blogs, :deleted_at
  end
end
