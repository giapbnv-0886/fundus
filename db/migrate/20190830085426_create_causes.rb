class CreateCauses < ActiveRecord::Migration[5.2]
  def change
    create_table :causes do |t|
      t.string :title
      t.text :detail
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :reached_money, default: 0
      t.decimal :goal_money, default: 0
      t.json :photos
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
