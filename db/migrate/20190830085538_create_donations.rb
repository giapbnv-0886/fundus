class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.decimal :amount, default: 0
      t.references :user, foreign_key: true
      t.references :cause, foreign_key: true

      t.timestamps
    end
  end
end
