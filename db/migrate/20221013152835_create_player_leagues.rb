class CreatePlayerLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :player_leagues do |t|
      t.references :player, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
