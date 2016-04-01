class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
  end
  def create
    render json: params
  end
  def show_date
    day = params[:date]
    @yesterday = (Date.parse(day) - 1.day).strftime("%F")
    @spaces = Space.all
    @events = Event.by_date day
  end
end
