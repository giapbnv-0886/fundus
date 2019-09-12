class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :type
      t.string :password_digest
      t.json :photo

      t.timestamps
    end
  end
end
