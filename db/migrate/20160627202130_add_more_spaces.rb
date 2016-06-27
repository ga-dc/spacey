class AddMoreSpaces < ActiveRecord::Migration
  def change
    Space.create([
      { title:"OpenGov Hub", classroom_cap: nil, lecture_cap: nil },
      { title:"Offsite", classroom_cap: nil, lecture_cap: nil },
    ])
  end
end
