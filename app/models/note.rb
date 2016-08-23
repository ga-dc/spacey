class Note < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  default_scope { order('updated_at DESC') }
end
