class CreateRecurringEvent < ActiveRecord::Migration
  def change
    create_table :recurring_events do |t|
      t.string :title
      t.references :event_type, index: true, foreign_key: true
    end
  end
end
