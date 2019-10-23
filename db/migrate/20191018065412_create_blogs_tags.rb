class CreateBlogsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs_tags, :id => false do |t|
      t.references :blog, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
