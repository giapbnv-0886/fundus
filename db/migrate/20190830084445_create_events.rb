class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.string :place
      t.integer :total_person
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :expiration_date
      t.json :photos
      t.json :geocode
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :events, [:created_at]
  end
end
