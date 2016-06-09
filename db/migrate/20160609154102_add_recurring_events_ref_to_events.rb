class AddRecurringEventsRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :recurring_event, index: true, foreign_key: true, null: true
  end
end
