class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.references :recurring_event, index: true, foreign_key: true
      t.references :space, index: true, foreign_key: true
    end
  end
end
