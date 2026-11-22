class Category < ApplicationRecord
  belongs_to :organization

  validates :category_name, presence: true
end
