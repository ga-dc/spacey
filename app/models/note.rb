class Note < ActiveRecord::Base
  belongs_to :event
  default_scope { order('updated_at DESC') }
end