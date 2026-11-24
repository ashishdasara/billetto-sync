require "rails_helper"

RSpec.describe EventLoaderJob, type: :job do
  let(:event_data) do
    {
      "id" => 1, "object" => "public_event", "kind" => "regular", "state" => "published",
      "title" => "Comedy", "description" => "A show", "url" => "https://example.com",
      "branded_url" => "https://example.com", "image_link" => "https://example.com/image.jpg",
      "availability" => true, "minimum_price" => { "amount_in_cents" => 100, "currency" => "DKK" },
      "startdate" => "2027-04-09T18:00:00Z",
      "organization" => { "id" => 1 }, "organiser" => { "id" => 1, "name" => "Organizer" },
      "categorization" => { "category" => "comedy" },
      "location" => {
        "location_name" => "Venue", "address_line" => "Main Street", "city" => "Køge",
        "postal_code" => "4600", "country" => "Danmark", "country_code" => "DK",
        "macroregion" => "Danmark", "region" => "Sjælland", "subregion" => "Østsjælland"
      }
    }
  end

  it "stores the start date and refreshes it for previously imported events" do
    fetcher = instance_double(Billetto::DataFetcher, fetch: { "data" => [ event_data ], "has_more" => false })
    allow(Billetto::DataFetcher).to receive(:new).and_return(fetcher)

    described_class.perform_now
    event = Event.find_by!(billetto_id: 1)
    expect(event.starts_at).to eq(Time.utc(2027, 4, 9, 18))

    event.update!(starts_at: nil)
    described_class.perform_now
    expect(event.reload.starts_at).to eq(Time.utc(2027, 4, 9, 18))
    expect(Event.count).to eq(1)

    event_data["startdate"] = "2027-04-10T18:00:00Z"
    described_class.perform_now
    expect(event.reload.starts_at).to eq(Time.utc(2027, 4, 10, 18))

    event_data.delete("startdate")
    described_class.perform_now
    expect(event.reload.starts_at).to eq(Time.utc(2027, 4, 10, 18))
  end
end
