class AddColumnsToDuser < ActiveRecord::Migration[5.2]
  def change
    add_column :dusers, :role, :integer, default: 0
  end
end
