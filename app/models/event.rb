class Event < ApplicationRecord
  belongs_to :organizer
  belongs_to :location
  belongs_to :category

  validates :billetto_id, :object_type, :kind, :state, :title, :description, :url, :branded_url,
            :image_link, :availability, :minimum_price_cents, :minimum_price_currency, presence: true
end
