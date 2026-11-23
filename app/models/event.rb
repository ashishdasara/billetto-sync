class Event < ApplicationRecord

  has_one :location
  belongs_to :category
  belongs_to :organizer
  belongs_to :organization

  validates :billetto_id, :object_type, :kind, :state, :title, :url, :branded_url,
            :image_link, :minimum_price_cents, :minimum_price_currency, presence: true
end
