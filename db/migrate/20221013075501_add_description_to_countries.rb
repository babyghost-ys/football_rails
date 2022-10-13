class AddDescriptionToCountries < ActiveRecord::Migration[7.0]
  def change
    add_column :countries, :description, :text
  end
end
