class RemoveHashTag < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :hash_tag
  end
end
