class AddReferencesToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :cause, foreign_key: true
  end
end
