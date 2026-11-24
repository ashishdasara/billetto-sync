require "rails_helper"

RSpec.describe Organization, type: :model do
  it "requires a Billetto ID" do
    organization = described_class.new

    expect(organization).not_to be_valid
    expect(organization.errors[:billetto_id]).to be_present
    organization.billetto_id = 123
    expect(organization).to be_valid
  end
end
