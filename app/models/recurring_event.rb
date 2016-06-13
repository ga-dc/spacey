class RecurringEvent < ActiveRecord::Base
  has_many :events
  has_many :spaces
  belongs_to :event_type
end
