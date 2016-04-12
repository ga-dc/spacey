class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text
      t.references :event, index: true, foreign_key: true
      t.timestamps
    end
  end
end
