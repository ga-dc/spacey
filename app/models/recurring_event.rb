class RecurringEvent < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :spaces
  belongs_to :event_type
  
  before_create :test_hook
  
  def test_hook
    puts '*' * 50
    puts self
    puts self.title
    puts '*' * 50
  end
  
  def self.recurring_helper(rrules, event_params, start_date, end_date)
    rec_rules  = RecurringSelect.dirty_hash_to_rule(rrules)
    dur_in_sec = end_date.seconds_since_midnight - start_date.seconds_since_midnight
    total_dur = (end_date.strftime("%s").to_i - start_date.strftime("%s").to_i)
    sched = Schedule.new(start_date, :duration => total_dur)
    sched.add_recurrence_rule(rec_rules)
    occurrences = sched.occurrences_between(start_date, end_date + 1.day)
    occurrences = occurrences.map{|o| o.to_datetime.change(:offset => "+0000")}
    return [dur_in_sec, sched, occurrences]
  end
  def create_events(rrules, event_params, start_date, end_date)
    dur_in_sec, sched, occurrences = self.recurring_helper(rrules, event_params, start_date, end_date)
    rec = RecurringEvent.create!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    occurrences.each do |occurrence|
      rec.events.create!(event_params.merge(start_date: occurrence, end_date: occurrence + dur_in_sec.seconds))
    end
  end
  
  def self.recurring_helper(rrules, event_params, start_date, end_date)
    rec_rules  = RecurringSelect.dirty_hash_to_rule(rrules)
    dur_in_sec = end_date.seconds_since_midnight - start_date.seconds_since_midnight
    total_dur = (end_date.strftime("%s").to_i - start_date.strftime("%s").to_i)
    sched = Schedule.new(start_date, :duration => total_dur)
    sched.add_recurrence_rule(rec_rules)
    occurrences = sched.occurrences_between(start_date, end_date + 1.day)
    occurrences = occurrences.map{|o| o.to_datetime.change(:offset => "+0000")}
    return [dur_in_sec, sched, occurrences]
  end
  def create_events(rrules, event_params, start_date, end_date)
    dur_in_sec, sched, occurrences = self.recurring_helper(rrules, event_params, start_date, end_date)
    rec = RecurringEvent.create!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    occurrences.each do |occurrence|
      rec.events.create!(event_params.merge(start_date: occurrence, end_date: occurrence + dur_in_sec.seconds))
    end
  end
  def update_events(rrules, event_params, start_date, end_date, recurring_event)
    new_st = start_date
    new_et = end_date
    if start_date.strftime('%D') == end_date.strftime('%D')
      old_st = recurring_event.start_date.to_datetime
      old_et = recurring_event.end_date.to_datetime
      start_date = DateTime.new(old_st.year, old_st.month, old_st.day, new_st.hour, new_st.minute, new_st.second)
      end_date = DateTime.new(old_et.year, old_et.month, old_et.day, new_et.hour, new_et.minute, new_et.second)
    end
    dur_in_sec, sched, occurrences = self.recurring_helper(rrules, event_params, start_date, end_date)
    recurring_event.update!(event_params.merge(start_date: start_date, end_date: end_date, recurring_rules: sched.to_hash))
    recurring_event.events.destroy_all
    occurrences.each do |occurrence|
      recurring_event.events.create!(event_params.merge(start_date: occurrence, end_date: occurrence + dur_in_sec.seconds))
    end
  end
end