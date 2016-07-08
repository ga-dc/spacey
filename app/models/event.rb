class Event < ActiveRecord::Base
  has_many :reservations
  has_many :notes, dependent: :destroy
  belongs_to :space
  belongs_to :event_type
  belongs_to :recurring_event
  
  validate :is_available, :is_postive_time, :room_capactity
  validates :space_id, :start_date, :end_date, :title, :event_style, presence: true
  
  scope :unapproved, -> { where('approved = false')}
  scope :same_space, -> (space_id){ where('space_id = ?', space_id)}
  scope :diff_event, -> (event_id){ where('id != ?', event_id)}
  scope :overlaping, -> (start, endd){ 
    return [] if endd - start > 1.day
    where('(? <= end_date AND ? >= start_date)', start, endd)
  }
  scope :by_date, -> (day){ where(start_date: day.beginning_of_day..day.end_of_day)}
  
  include IceCube
  attr_accessor :recurring_rules
  
  def repeat days
    days = self.end_date - self.start_date
    current_day = self.start_date
    days.each do |d|
      current_day += 1
    end
  end
  def as_json(options = { })
      h = super(options)
      h[:color]   =  self.event_type && self.event_type.color || "#000"
      h
  end
  def is_available
    start = self.start_date
    endd = self.end_date
    @events = Event.same_space(self.space_id).diff_event(self.id).overlaping(start, endd)
    if @events.count > 0
      errors.add(:event, "space and time are not available during the date/time you requested.<br>These events conflict: " + @events.map{|e|  "https://gadc.space/events/" + e.id.to_s }.join("<br>"))
    end
  end
  def is_postive_time
    if (self.start_date > self.end_date) || (self.start_date == self.end_date)
      errors.add(:event, "time is not valid, the start must come before the end.")
    end
  end
  def room_capactity
    @space = Space.find(self.space_id)
    if self.event_style == 'Lecture'
      if self.number_of_attendees && self.number_of_attendees > @space.lecture_cap
        errors.add(:event, "space selected has a max lecture capacity of #{@space.lecture_cap}, please select a different space." )
      end
    else
      if self.number_of_attendees && self.number_of_attendees > @space.classroom_cap
        errors.add(:event, "space selected has a max classroom capacity of #{@space.classroom_cap}, please select a different space." )
      end
    end
  end
  # TODO validation for recurring events sucks
  # TODO can't update non-recurring event to become recurring
  def color
    if self.custom_color
      self.custom_color
    elsif self.event_type
      self.event_type.color
    end
  end
end
