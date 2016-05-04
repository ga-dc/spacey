class AddNumOfAttendeesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :number_of_attendees, :integer
  end
end
