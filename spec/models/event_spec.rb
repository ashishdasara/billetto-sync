require "rails_helper"

RSpec.describe Event, type: :model do
  it "requires the fields needed for an imported event" do
    event = described_class.new

    expect(event).not_to be_valid
    expect(event.errors.attribute_names).to include(
      :billetto_id, :object_type, :kind, :state, :title, :url, :branded_url,
      :image_link, :minimum_price_cents, :minimum_price_currency,
      :category, :organizer, :organization
    )
  end
end
