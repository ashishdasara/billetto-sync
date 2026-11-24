module ApplicationHelper
  def display_time(event)
    if event.starts_at.present?
      content_tag(:div) do
        concat(content_tag(:i, "", class: "fa fa-clock-o"))
        concat(" ")
        concat(time_tag(event.starts_at, format: "%B %-d, %Y at %H:%M %Z"))
      end
    else
      content_tag(:div, "Date unavailable")
    end
  end

  def display_category(event)
    if event.category.present?
      cat_name = event.category.category_localized
      category_name = content_tag(:div, cat_name)
      category_name
    else
      content_tag(:div, "Category unavailable")
    end
  end

  def display_location(event)
    if event.location.present?
      loc_string = event.location.location_string
      content_tag(:p) do
        concat(content_tag(:i, "", class: "fa fa-map-marker"))
        concat(" ")
        concat(loc_string)
      end
    else
      content_tag(:p, "Location unavailable")
    end
  end

  def vote_history_description(event)
    previous_direction = event.data.with_indifferent_access[:previous_direction]

    case event
    when EventUpvoted
      previous_direction ? "Changed from Dislike to Like" : "Liked"
    when EventDownvoted
      previous_direction ? "Changed from Like to Dislike" : "Disliked"
    when EventVoteRemoved
      "Removed a #{previous_direction == "up" ? "like" : "dislike"} vote"
    else
      "Vote activity recorded"
    end
  end
end
