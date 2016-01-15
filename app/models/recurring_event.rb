class RecurringEvent < ActiveRecord::Base
  has_many :events
  has_many :spaces, through: :events
  belongs_to :event_type
end
