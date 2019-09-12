class CreateDusers < ActiveRecord::Migration[5.2]
  def change
    create_table :dusers do |t|

      t.timestamps
    end
  end
end
