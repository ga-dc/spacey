class Event < ActiveRecord::Base
  belongs_to :space
  belongs_to :event_type
  has_many :reservations
  def repeat days
    days = self.end_date - self.start_date
    current_day = self.start_date
    days.each do |d|
      current_day += 1
    end
  end
  def self.by_date day
    all.select{|e| e.start_date.strftime("%F") == day }
  end
  def as_json(options = { })
      h = super(options)
      h[:color]   =  self.event_type && self.event_type.color || "#000"
      h
  end

end
