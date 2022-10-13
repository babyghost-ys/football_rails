class AddColumnsToCountries < ActiveRecord::Migration[7.0]
  def change
    add_column :countries, :capital, :string
    add_column :countries, :region, :string
    add_column :countries, :languages, :string
    add_column :countries, :population, :decimal
    add_column :countries, :area, :float
  end
end
