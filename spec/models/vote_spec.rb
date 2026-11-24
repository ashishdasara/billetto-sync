require "rails_helper"

RSpec.describe Vote, type: :model do
  let(:event) { Event.new }

  it "requires a user and an event" do
    vote = described_class.new(direction: "up")
    expect(vote).not_to be_valid
    expect(vote.errors.attribute_names).to include(:user_id, :event)
  end

  it "accepts only up and down directions" do
    vote = described_class.new(event: event, user_id: "user_123")
    %w[up down].each do |direction|
      vote.direction = direction
      expect(vote).to be_valid
    end
    vote.direction = "sideways"
    expect(vote).not_to be_valid
    expect(vote.errors[:direction]).to be_present
  end
end
