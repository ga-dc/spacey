class RecurringEvent < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :spaces
  belongs_to :event_type
  
  validates :space_id, :start_date, :end_date, :title, :event_style, :recurring_rules, presence: true
  after_create :create_events
  
  include IceCube
  attr_accessor :recurring_rules
  
  def create_events
    sched = Schedule.from_hash(self.recurring_rules)
    dur_in_sec = self.end_date.seconds_since_midnight - self.start_date.seconds_since_midnight
    occurrences = sched.occurrences_between(self.start_date, self.end_date + 1.day)
    occurrences = occurrences.map{|o| o.to_datetime.change(:offset => "+0000")}
    occurrences.each do |occurrence|
      data = self.serializable_hash.merge("start_date"=> occurrence, "end_date"=> occurrence + dur_in_sec.seconds)
      data.delete("id")
      self.events.create!(data)
    end
  end
  def update_events
    self.events.destroy_all
    create_events
  end

end