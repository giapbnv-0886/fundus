class AddColumnsToDonations < ActiveRecord::Migration[5.2]
  def self.up
    change_table :donations do |t|
      t.string :description
      t.string :token
      t.string :payer_id
      t.datetime :purchased_at
    end
  end
end
