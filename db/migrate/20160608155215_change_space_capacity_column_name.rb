class ChangeSpaceCapacityColumnName < ActiveRecord::Migration
  def change
    rename_column :spaces, :capacity, :classroom_cap
    add_column :spaces, :lecture_cap, :integer
  end
end
