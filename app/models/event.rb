class Event < ActiveRecord::Base
  belongs_to :space
  belongs_to :recurring_event
end
