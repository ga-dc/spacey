class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :start_time
      t.datetime :end_date
      t.datetime :end_time
      t.references :recurring_event, index: true, foreign_key: true
      t.references :space, index: true, foreign_key: true
    end
  end
end
