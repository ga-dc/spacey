class Reservation < ActiveRecord::Base
  belongs_to :event
end
