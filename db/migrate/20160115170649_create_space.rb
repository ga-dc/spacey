class CreateSpace < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :title
      t.integer :capacity
    end
  end
end
