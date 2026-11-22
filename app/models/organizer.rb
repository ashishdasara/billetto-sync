class Organizer < ApplicationRecord
  has_many :categories

  # validates :name, presence: true
end
