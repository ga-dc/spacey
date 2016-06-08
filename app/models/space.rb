class Space < ActiveRecord::Base
  has_many :events
  has_many :recurring_events, through: :events
  validates :title, presence: true
  # validate :capacity
  # 
  # def capacity
  #   if classroom_cap.blank? || lecture_cap.blank?
  #     errors.add(:base, "Spaces need a classroom capacity and/or a lecture capacity")
  #   end
  # end
end
