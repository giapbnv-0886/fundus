class AddColumnsToNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :action
    add_column :notifications, :read, :boolean, default: false
    add_column :notifications, :notice, :text
    remove_column :notifications, :recipient_id
  end
end
