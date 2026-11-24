class EventVoteRecorder
  def initialize(event:, user_id:, direction: "unchanged")
    @event = event
    @user_id = user_id
    @direction = direction
  end

  def record
    result = :unchanged

    @event.with_lock do
      vote = @event.votes.find_or_initialize_by(user_id: @user_id)
      previous_direction = vote.direction

      if previous_direction == @direction
        vote.destroy!
        event_class = EventVoteRemoved
        direction = nil
        result = :removed
      else
        vote.update!(direction: @direction)
        event_class = @direction == "up" ? EventUpvoted : EventDownvoted
        direction = @direction
        result = :recorded
      end

      publish_event(event_class, direction, previous_direction)
    end

    result
  end

  private

  def publish_event(event_class, direction, previous_direction)
    Rails.configuration.event_store.publish(
      event_class.new(data: {
        event_id: @event.id,
        user_id: @user_id,
        direction: direction,
        previous_direction: previous_direction
      }),
      stream_name: "Event-#{@event.id}"
    )
  end
end
