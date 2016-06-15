require "rails_helper"

RSpec.describe "RecurringEvent" do
  @sp = Space.create!(title:"dummy room", lecture_cap: 30)
  params = {'event' => {"title"=>"Test",
 "space_id"=>@sp.id,
 "event_style"=>"Class",
 "event_type_id"=>"1",
 "start_date"=>"2016/06/10 10:00",
 "end_date"=>"2016/06/17 17:00",
 "recurring_rules"=> {"validations": {"day":[1,
2,
3,
4,
5] },
"rule_type":"IceCube::WeeklyRule",
"interval":1,
"week_start":0 },
 "producer"=>"",
 "instructor"=>"",
 "number_of_attendees"=>"",
 "approved"=>"0"},
 "commit"=>"Create Event"}
  event_params = {title: "Test"}
  start_date = DateTime.parse(params['event']['start_date'])
  end_date = DateTime.parse(params['event']['end_date'])
  
  @re = Event.create_recurring_events(params, event_params, start_date, end_date)
end
