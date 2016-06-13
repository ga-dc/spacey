class AddColoumnsToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :recurring_event, index: true, foreign_key: true, null: true
    add_column :events, :created_at, :datetime
    add_column :events, :updated_at, :datetime
  end
end
