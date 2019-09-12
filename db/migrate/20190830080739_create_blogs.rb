class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.json :photo
      t.string :category
      t.string :references

      t.timestamps
    end
  end
end
