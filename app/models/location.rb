class Location < ApplicationRecord
  validates :address_line, :city, :postal_code, :country, :country_code, presence: true
end
