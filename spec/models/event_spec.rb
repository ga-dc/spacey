require "rails_helper"

RSpec.describe "Event" do

 it "has an event type" do
   et = EventType.create(title:"any")
   @e = Event.create
   @e.event_type = et
   @e.save
   expect(@e.event_type.title).to eq("any")
 end

 it "'s event type has a color" do
   et = EventType.create(title:"any", color: "#bada55")
   expect(et.color).to eq("#bada55")
 end

end