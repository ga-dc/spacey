class RecurringEvent < ActiveRecord::Base
  belongs_to :space
  belongs_to :event_type
  has_many :events,  dependent: :destroy
  # has_many :events, optional: true,  dependent: :destroy
end
