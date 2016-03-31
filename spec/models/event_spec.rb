require "rails_helper"

RSpec.describe "Event" do
  @space = Space.last
  let(:e){
    Event.create!(
      title: "wdi8",
      space: @space,
      start_time: Time.now - 20.days,
      start_date: Time.now - 20.days,
      end_time: Time.now,
      end_date: Time.now,
    )
  }

  describe "creating reservations" do
    it "should create at least one reservation" do
      e.repeat(["Monday", "Tuesday"])
      expect(e.reservations.count > 1).to eq(true)
    end
  end
end