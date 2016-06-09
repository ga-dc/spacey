require "rails_helper"

RSpec.describe "Event" do
  
  before(:each) do
    @sp = Space.create(title:"dummy room", lecture_cap: 30)
    @et = EventType.create(title:"any")
    today = DateTime.now.strftime("%e").to_i
    @e = @sp.events.create!(
      start_date: DateTime.now.change({hour: 5, minute: 0, day: today}),
      end_date: DateTime.now.change({hour: 7, minute:0, day: today}), title:"testy",
      number_of_attendees: 20,
      event_style: "Lecture"
    )
  end
    
  describe "initialized in before(:each)" do
    it "event type has a title" do
      expect(@et.title).to eq("any")
    end
    
    describe "@space" do
      it "has a title" do
        expect(@sp.title).to eq("dummy room")
      end
      
      it "has an event associated with it" do
        expect(@sp.events).to exist
      end
    end
  end
  
  it "can have event_type associated" do
    @e.event_type = @et
    @e.save
    expect(@e.event_type.title).to eq("any")
  end

  it "'s event type has a color" do
    evt = EventType.create(title:"any", color: "#bada55")
    expect(evt.color).to eq("#bada55")
  end

end