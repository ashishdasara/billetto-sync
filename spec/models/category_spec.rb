require "rails_helper"

RSpec.describe Category, type: :model do
  it "requires a category name and an organization" do
    category = described_class.new

    expect(category).not_to be_valid
    expect(category.errors[:category_name]).to be_present
    expect(category.errors[:organization]).to be_present
  end
end
