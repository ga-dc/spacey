class Space < ActiveRecord::Base
  has_many :events
  has_many :recurring_events, through: :events
  validates :title, presence: true
end
