class AddCountryToLeagues < ActiveRecord::Migration[7.0]
  def change
    add_reference :leagues, :country, null: false, foreign_key: true
  end
end
