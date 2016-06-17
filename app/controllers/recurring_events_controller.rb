class RecurringEventsController < ApplicationController
  def create
    dur_in_sec, sched, occurrences = RecurringEvent.recurring_helper(rrules, event_params, start_date, end_date)
    rec = RecurringEvent.create!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    occurrences.each do |occurrence|
      rec.events.create!(event_params.merge(start_date: occurrence, end_date: occurrence + dur_in_sec.seconds))
    end
    render json: {"action": "create"}
  end
  def update
    recurring_event.update!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    render json: {"action": "update"}
    if start_date.strftime('%D') == end_date.strftime('%D')
      old_st = recurring_event.start_date.to_datetime
      old_et = recurring_event.end_date.to_datetime
      start_date = DateTime.new(old_st.year, old_st.month, old_st.day, start_date.hour, start_date.minute, start_date.second)
      end_date = DateTime.new(old_et.year, old_et.month, old_et.day, end_date.hour, end_date.minute, end_date.second)
    end
    dur_in_sec, sched, occurrences = RecurringEvent.recurring_helper(rrules, event_params, start_date, end_date)
    recurring_event.update!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    recurring_event.events.destroy_all
    occurrences.each do |occurrence|
      recurring_event.events.create!(event_params.merge(start_date: occurrence, end_date: occurrence + dur_in_sec.seconds))
    end
  end
  def destroy
    @recurring_event = RecurringEvent.find(params[:id])
    @recurring_event.destroy
    redirect_to root_path
  end
end