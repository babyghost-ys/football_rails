class AddTypeToLeague < ActiveRecord::Migration[7.0]
  def change
    add_reference :leagues, :type, null: false, foreign_key: true
  end
end
