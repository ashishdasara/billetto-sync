class Event < ApplicationRecord
  belongs_to :category
  belongs_to :location
  belongs_to :organizer
  belongs_to :organization

  validates :billetto_id, :object_type, :kind, :state, :title, :description, :url, :branded_url,
            :image_link, :availability, :minimum_price_cents, :minimum_price_currency, presence: true
end
