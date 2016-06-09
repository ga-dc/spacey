class CreateRecurringEvents < ActiveRecord::Migration
  def change
    create_table :recurring_events do |t|
      t.integer :weeks_repeated
      t.boolean :days_repeated_on, array: true, default:[false, false, false, false, false, false, false]
      t.string   :title
      t.datetime :start_date
      t.datetime :end_date
      t.string   :kind
      t.string   :producer
      t.string   :instructor
      t.boolean  :approved
      t.integer  :number_of_attendees
      t.string   :event_style
      t.references :space, index: true, foreign_key: true
      t.references :event_type, index: true, foreign_key: true
    end
  end
end
