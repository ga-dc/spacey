class Event < ActiveRecord::Base
  include IceCube
  
  has_many :reservations
  has_many :notes
  belongs_to :space
  belongs_to :event_type
  
  validate :is_available, :room_capactity
  # validates :space_id, :start_date, :end_date, :title, :event_style, presence: true
  
  attr_accessor :recurring_rules
  
  scope :same_space, -> (space_id){ where('space_id = ?', space_id)}
  scope :diff_event, -> (event_id){ where('id != ?', event_id)}
  scope :overlaping, -> (start, endd){ where('(? <= end_date AND ? >= start_date)', start, endd)}
  
  
  serialize :recurring_rules, Hash

  def recurring_rules=(new_recurring_rules)
    write_attribute(:recurring_rules, RecurringSelect.dirty_hash_to_rule(new_recurring_rules).to_hash)
  end
  def converted_recurring_rules
    the_recurring_rules = Schedule.new(self.start_date)
    the_recurring_rules.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(self.recurring_rules))
    the_recurring_rules
  end
  
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
    @events = Event.same_space(self.space_id).diff_event(self.id).overlaping(start, endd)
    if @events.count > 0
      errors.add(:event, "space and time are not available during the date/time you requested." )
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
end
