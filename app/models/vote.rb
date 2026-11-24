class Vote < ApplicationRecord
  DIRECTIONS = %w[up down].freeze

  belongs_to :event

  validates :user_id, presence: true
  validates :direction, inclusion: { in: DIRECTIONS }
end
