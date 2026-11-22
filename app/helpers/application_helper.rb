module ApplicationHelper
  def display_time(event)
    if event.starts_at.present?
      content_tag(:p) do
        time_tag(event.starts_at, format: "%B %-d, %Y at %H:%M %Z")
      end
    else
      content_tag(:p, "Date unavailable")
    end
  end
end
