class AddDeletedAtToDonations < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :deleted_at, :datetime
    add_index :donations, :deleted_at
  end
end
