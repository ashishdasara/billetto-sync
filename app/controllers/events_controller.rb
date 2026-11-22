class EventsController < ApplicationController
  PER_PAGE = 20
  MAX_PAGE = (Event.count.to_f / PER_PAGE).ceil

  def index
    page_param = params[:page] || 1

    if page_param.to_i > MAX_PAGE
      page_param = MAX_PAGE
    end

    @events = Event.order(:id).includes(:location, :category).page(page_param.to_i).per(PER_PAGE)
  end
end
