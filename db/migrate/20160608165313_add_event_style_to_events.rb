class AddEventStyleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_style, :string
  end
end
