class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
  end
  def create
    start_date = DateTime.parse(params[:event][:start_date])
    end_date = DateTime.parse(params[:event][:end_date])
    Event.create(event_params.merge(start_date: start_date, end_date: end_date))
    redirect_to "/days/" + Time.now.strftime("%F")
  end
  def show
    @event = Event.find(params[:id])
  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to "/days/" + Time.now.strftime("%F")
  end
  def show_date
    day = params[:date]
    @today = Date.parse(day).strftime("%A, %b %e, %Y")
    @yesterday = (Date.parse(day) - 1.day).strftime("%F")
    @tomorrow = (Date.parse(day) + 1.day).strftime("%F")
    @spaces = Space.all
    @events = Event.by_date day
  end
  def check_availability
    start = DateTime.parse(params[:start_date])
    endd = DateTime.parse(params[:end_date])
    @events = Event.where('space_id = ?', params[:space_id]).where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)', start, start, endd, endd)
    if @events.count > 0
      render json: false
    else
      render json: true
    end
  end
  private
  def event_params
    params.require(:event).permit(:title, :space_id, :kind)
  end
end
