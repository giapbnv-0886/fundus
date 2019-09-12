class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :reply_for, default: 0
      t.references :blog, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
