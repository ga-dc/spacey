class AddCustomColorToRecurringEvents < ActiveRecord::Migration
  def change
    add_column :recurring_events, :custom_color, :string
  end
end
