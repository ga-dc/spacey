class EventType < ActiveRecord::Base
  has_many :recurring_events
end
