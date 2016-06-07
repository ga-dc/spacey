require "rails_helper"

RSpec.describe "Event" do

  it "bogus test to refactor later" do
    sp = Space.create(title:"dummy room", capacity: 30)
    et = EventType.create(title:"any")
    today = DateTime.now.strftime("%e").to_i
    @e = sp.events.create!(
      start_date: DateTime.now.change({hour: 5, minute: 0, day: today}),
      end_date: DateTime.now.change({hour: 7, minute:0, day: today}), title:"testy",
      number_of_attendees: 20
    )
    @e.event_type = et
    @e.save
    expect(@e.event_type.title).to eq("any")
  end

  it "'s event type has a color" do
    et = EventType.create(title:"any", color: "#bada55")
    expect(et.color).to eq("#bada55")
  end

end