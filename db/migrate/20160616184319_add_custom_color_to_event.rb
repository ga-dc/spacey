class AddCustomColorToEvent < ActiveRecord::Migration
  def change
    add_column :events, :custom_color, :string
  end
end