class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurring_rules, :text
  end
end
