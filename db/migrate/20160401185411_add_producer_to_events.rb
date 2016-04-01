class AddProducerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :producer, :string
    add_column :events, :instructor, :string
  end
end
