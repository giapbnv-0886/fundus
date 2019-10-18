class EventsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :events_tags, :id => false do |t|
      t.references :event, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
