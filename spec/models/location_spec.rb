require "rails_helper"

RSpec.describe Location, type: :model do
  it "formats populated address components without blank separators" do
    location = described_class.new(
      location_name: "Venue", address_line: "Main Street", address_line_2: " ",
      postal_code: "4600", city: "Køge", country: "Danmark"
    )

    expect(location.location_string).to eq("Venue, Main Street, 4600, Køge, Danmark")
  end

  it "requires an event" do
    location = described_class.new

    expect(location).not_to be_valid
    expect(location.errors[:event]).to be_present
  end
end
