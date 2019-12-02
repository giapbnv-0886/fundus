class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :hash_tag
      t.text :content
      t.json :photo
      t.references :category, foreign_key: true
      t.timestamps
    end
    add_index :blogs, [ :created_at]

  end
end
