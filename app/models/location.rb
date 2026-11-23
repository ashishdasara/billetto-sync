class Location < ApplicationRecord
  # validates :address_line, :city, :country, :country_code, presence: true

  belongs_to :event

  def location_string
    [location_name, address_line, address_line_2, postal_code, city, country].compact_blank.join(", ")
  end
end
