class AddSpaces < ActiveRecord::Migration
  def change
    Space.create([
      { title:"Area A", classroom_cap: nil, lecture_cap: 100 },
      { title:"Area AB", classroom_cap: nil, lecture_cap: 225 },
      { title:"Area ABC", classroom_cap: nil, lecture_cap: 500 },
      { title:"Area C", classroom_cap: nil, lecture_cap: 100 }
    ])
  end
end
