class CreateDUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :d_users do |t|

      t.timestamps
    end
  end
end
