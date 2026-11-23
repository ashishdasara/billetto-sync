class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :address_line
      t.string :address_line_2
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :country_code
      t.string :macroregion
      t.string :region
      t.string :subregion
      t.decimal :latitude
      t.decimal :longitude
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
