class RecurringEventsController < ApplicationController
  include IceCube
      
  def create
    start_date, end_date, sched = recurring_info(params)
    recurring_event = RecurringEvent.create!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    
    render :js => "window.location = '/days/#{recurring_event.start_date.strftime("%F")}'"
  end
  def update
    start_date, end_date, sched = recurring_info(params)
    recurring_event = RecurringEvent.find(params[:id])
    recurring_event.update!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    
    render :js => "window.location = '/days/#{recurring_event.start_date.strftime("%F")}'"
  end
  def destroy
    @recurring_event = RecurringEvent.find(params[:id])
    @recurring_event.destroy
    redirect_to root_path
  end
  
  private
  def event_params
    params.require(:event).permit(:title, :space_id, :event_type_id, :producer, :approved, :instructor, :number_of_attendees, :start_date, :end_date, :kind, :event_style, :recurring_rules, :custom_color)
  end
  def recurring_info(params)
    start_date = DateTime.parse(params[:event][:start_date])
    end_date = DateTime.parse(params[:event][:end_date])
    rec_rules  = RecurringSelect.dirty_hash_to_rule(params['event']['recurring_rules'])
    total_dur = (end_date.strftime("%s").to_i - start_date.strftime("%s").to_i)
    sched = Schedule.new(start_date, :duration => total_dur)
    sched.add_recurrence_rule(rec_rules)
    return [start_date, end_date, sched]
  end
end