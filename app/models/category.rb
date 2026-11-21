class Category < ApplicationRecord
  belongs_to :organizer

  validates :category_name, presence: true
end
