class AddEventTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_type_id, :integer, index: true
  end
end
