class CausesTags < ActiveRecord::Migration[5.2]
  def change
    create_table :causes_tags, :id => false do |t|
      t.references :cause, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
