class AddDeletedAtToCauses < ActiveRecord::Migration[5.2]
  def change
    add_column :causes, :deleted_at, :datetime
    add_index :causes, :deleted_at
  end
end
