class EventsController < ApplicationController
  PER_PAGE = 20
  MAX_PAGE = (Event.count.to_f / PER_PAGE).ceil

  def index
    page_param = params[:page] || 1

    if page_param.to_i > MAX_PAGE
      page_param = MAX_PAGE
    end

    @events = Event.order(:id).includes(:location, :category).page(page_param.to_i).per(PER_PAGE)
    @current_user_id = clerk&.user_id
    event_ids = @events.pluck(:id)
    @vote_counts = Vote.where(event_id: event_ids).group(:event_id, :direction).count

    @current_user_votes = if @current_user_id.present?
      Vote.where(event_id: event_ids, user_id: @current_user_id).index_by(&:event_id)
    else
      {}
    end
  end

  def show
    @event = Event.includes(:location).find(params[:id])
    @vote_history = Rails.configuration.event_store.read.stream("Event-#{@event.id}").to_a
  end
end
