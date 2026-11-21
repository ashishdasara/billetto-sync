class Location < ApplicationRecord
  validates :location_name, :address_line, :city, :postal_code, :country, :country_code, presence: true
end
