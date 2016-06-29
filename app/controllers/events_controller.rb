class EventsController < ApplicationController
  include IceCube
    
  def index
    @events = Event.all
  end
  def show
    @event = Event.find(params[:id])
    if @event.recurring_event_id
      @recurring_event = RecurringEvent.find(@event.recurring_event_id)
    end
    @note = Note.new
  end
  def queue
    @events = Event.where(approved: nil).order(start_date: :desc)
    authorize! :approve, @events.last || Event.new
  end
  def new
    @event = Event.new
  end
  def create
    start_date = DateTime.parse(params[:event][:start_date])
    end_date = DateTime.parse(params[:event][:end_date])
    if params[:event][:recurring_rules] != "null"
      Event.create_recurring_events(params, event_params, start_date, end_date)
      redirect_to root_path
    else
      @event = Event.new(event_params.merge(start_date: start_date, end_date: end_date))
      if @event.save
        respond_to do |format|
          format.html { redirect_to show_date_path(@event.start_date.strftime("%F")) }
          format.json { render json: @event }
        end
      else
        render :js => "alert('Something went wrong. Check the details and try again.')"      
      end
    end
  end
  def edit
    @event = Event.find(params[:id])
    if @event.recurring_event_id
      @recurring_event = RecurringEvent.find(@event.recurring_event_id)
    else 
      @recurring_event = nil
    end
  end
  def update
    start_date = DateTime.parse(params[:event][:start_date])
    end_date = DateTime.parse(params[:event][:end_date])
    @event = Event.find(params[:id])
    recurring_event = @event.recurring_event if @event.recurring_event_id
    @recurring_event = recurring_event
    start_date = start_date.change(day: @event.start_date.day)
    end_date = end_date.change(day: @event.end_date.day)
    if @event.update(event_params.merge(start_date: start_date, end_date: end_date))
      respond_to do |format|
        format.html { redirect_to show_date_path(@event.start_date.strftime("%F")) }
        format.json { render json: @event }
      end
    else
      render :js => "alert('Something went wrong. Check the details and try again.')"
    end
  end
  def update_approval
    # TODO bulk approval for recurring_events
    @event = Event.find(params[:event_id])
    if params[:commit] == 'Approve'
      @event.approved = true
    elsif params[:commit] == 'Deny'
      @event.approved = false
    end
    if @event.save!
      redirect_to events_queue_path
    else
      redirect_to events_queue_path
    end
  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    go_back
  end
  def show_date
    day = params[:date] || Date.today.to_s
    @day = Date.parse(day)
    @today = @day.strftime("%A, %b %e, %Y")
    @yesterday = (Date.parse(day) - 1.day).strftime("%F")
    @tomorrow = (Date.parse(day) + 1.day).strftime("%F")
    @spaces = Space.all
    @events = Event.by_date(@day).order('start_date ASC')
    @year = Date.parse(day).strftime("%Y")
    @week = Date.parse(day).strftime("%W")
    if params[:view] == "week"
      @events = Event.where("start_date > ? AND end_date < ?", @day.beginning_of_week, @day.end_of_week)
    end
    if params[:view] == "month"
      @events = Event.where("start_date > ? AND end_date < ?", @day.beginning_of_month, @day.end_of_month)
    end
    session[:last_view] = request.original_url
  end
  def check_availability
    start = DateTime.parse(params[:start_date])
    endd = DateTime.parse(params[:end_date])
    @events = Event.same_space(params[:space_id]).overlaping(start, endd)
    if @events.count > 0
      render json: false
    else
      render json: true
    end
  end
  private
  def event_params
    params.require(:event).permit(:title, :space_id, :event_type_id, :producer, :approved, :instructor, :number_of_attendees, :start_date, :end_date, :kind, :event_style, :recurring_rules, :custom_color)
  end
  def go_back
    return redirect_to session[:last_view] if session[:last_view]
    redirect_to :back
  end
end