class Event < ActiveRecord::Base
  belongs_to :space
  belongs_to :event_type
  validate :is_available
  has_many :reservations
  has_many :notes
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
  def is_available
    start = self.start_date
    endd = self.end_date
    @events = Event.where('space_id = ?', self.space_id).where('id != ?', self.id).where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)', start, start, endd, endd)
    if @events.count > 0
      errors.add(:event, "space and time are not available during the date/time you requested." )
    end
  end

end
