class VotesController < ApplicationController
  before_action :require_authenticated_user
  before_action :set_event

  def create
    direction = params[:direction]

    unless Vote::DIRECTIONS.include?(direction)
      redirect_back fallback_location: root_path, allow_other_host: false,
                    alert: "Choose an upvote or downvote."
      return
    end

    result = EventVoteRecorder.new(event: @event, user_id: clerk.user_id, direction: direction).record
    message = vote_message(result)
    redirect_back fallback_location: root_path, allow_other_host: false, notice: message
  end

  private

  def require_authenticated_user
    return if clerk&.user_id.present?

    redirect_back fallback_location: root_path, allow_other_host: false, alert: "Sign in before voting."
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def vote_message(result)
    case result
    when :recorded then "Your vote was recorded."
    when :removed then "Your vote was removed."
    else "Your vote was unchanged."
    end
  end
end
