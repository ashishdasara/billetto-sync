class EventLoaderJob < ApplicationJob
  queue_as :default

  def perform(url = nil)
    response_data = Billetto::DataFetcher.new.fetch(url)

    # response has keys:  ["object", "data", "has_more", "total", "url", "next_url"]
    events_data = response_data&.dig("data")
    sync_data(events_data)

    if response_data&.dig("has_more")
      puts "More events available: #{response_data.dig("next_url")}"
      self.class.perform_later(response_data.dig("next_url"))
    end
  end

  private

  def sync_data(events_data)
    events_data.each do |event_data|
      org       = create_or_update_organization(event_data["organization"])
      organizer = create_or_update_organizer(event_data["organiser"])
      location  = create_or_update_location(event_data["location"])
      category  = create_or_update_category(event_data["categorization"], org)

      event = Event.find_or_initialize_by(billetto_id: event_data["id"])
        event.assign_attributes(
          object_type:  event_data["object"].strip,
          kind:         event_data["kind"].strip,
          state:        event_data["state"].strip,
          title:        event_data["title"].strip,
          description:  event_data["description"].strip,
          url:          event_data["url"].strip,
          branded_url:  event_data["branded_url"].strip,
          image_link:   event_data["image_link"].strip,
          starts_at:    event_data["startdate"],
          ends_at:      event_data["enddate"],
          availability: event_data["availability"],
          minimum_price_cents:    event_data["minimum_price"]["amount_in_cents"].to_i,
          minimum_price_currency: event_data["minimum_price"]["currency"].strip,
          category:     category,
          location:     location,
          organizer:    organizer,
          organization: org
        )
      event.save!

    rescue StandardError => e
      Rails.logger.error("Failed to sync event: #{e.message}")
      next
    end
  end

  def create_or_update_organization(org_data)
    org = Organization.find_or_create_by!(billetto_id: org_data["id"])
    org
  end

  def create_or_update_location(location_data)
    location = Location.find_or_create_by!(
      location_name:  location_data["location_name"].strip,
      address_line:   location_data["address_line"].strip,
      address_line_2: location_data["address_line_2"]&.strip,
      city:           location_data["city"].strip,
      postal_code:    location_data["postal_code"].strip,
      country:        location_data["country"].strip,
      country_code:   location_data["country_code"].strip,
      macroregion:    location_data["macroregion"].strip,
      region:         location_data["region"].strip,
      subregion:      location_data["subregion"].strip,
      latitude:       location_data.dig("coordinates", "latitude"),
      longitude:      location_data.dig("coordinates", "longitude")
    )

    location
  end

  def create_or_update_category(category_data, org)
    category = Category.find_or_create_by!(
      category_name: category_data["category"],
      category_localized: category_data["category_localized"],
      subcategory: category_data["subcategory"],
      subcategory_localized: category_data["subcategory_localized"],
      category_type: category_data["type"],
      category_type_localized: category_data["type_localized"],
      organization_id: org.id
    )
    category
  end

  def create_or_update_organizer(organizer_data)
    organizer = Organizer.find_or_create_by!(billetto_id: organizer_data["id"], name: organizer_data["name"].strip)
    organizer
  end
end
