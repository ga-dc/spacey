class CreateEventType < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :color
      t.string :title
    end
  end
end
