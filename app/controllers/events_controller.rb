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
    @event = Event.new(event_params.merge(start_date: start_date, end_date: end_date))
    if @event.save
      redirect_to "/days/" + @event.start_date.strftime("%F")
    else
      render "new"
    end
  end
  def update
    start_date = DateTime.parse(params[:event][:start_date])
    end_date = DateTime.parse(params[:event][:end_date])
    @event = Event.find(params[:id])
    if @event.update(event_params.merge(start_date: start_date, end_date: end_date))
      redirect_to "/days/" + @event.start_date.strftime("%F")
    else
      render "edit"
    end
  end
  def show
    @event = Event.find(params[:id])
    @note = Note.new
  end
  def edit
    @event = Event.find(params[:id])
  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to "/days/" + Time.now.strftime("%F")
  end
  def show_date
    day = params[:date] || Date.today.to_s
    @today = Date.parse(day).strftime("%A, %b %e, %Y")
    @yesterday = (Date.parse(day) - 1.day).strftime("%F")
    @tomorrow = (Date.parse(day) + 1.day).strftime("%F")
    @spaces = Space.all
    @events = Event.by_date(day)
    @year = Date.parse(day).strftime("%Y")
    @week = Date.parse(day).strftime("%W")
  end
  def show_week
    @year = params[:year].to_i
    week = params[:number].to_i
    @start_of_week = Date.commercial(@year, week, 1)
    @end_of_week = Date.commercial(@year, week, 7)
    @events = Event.where("start_date > ? AND end_date < ?", @start_of_week, @end_of_week)
    @spaces = Space.all
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
    params.require(:event).permit(:title, :space_id, :event_type_id, :producer, :approved, :instructor, :number_of_attendees, :event_style)
  end
end
