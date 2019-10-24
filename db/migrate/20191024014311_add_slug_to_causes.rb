class AddSlugToCauses < ActiveRecord::Migration[5.2]
  def change
    add_column :causes, :slug, :string
    add_index :causes, :slug
  end
end
