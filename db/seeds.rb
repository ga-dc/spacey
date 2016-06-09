Note.destroy_all
EventType.destroy_all
Event.destroy_all
Space.destroy_all
spaces = Space.create([
  { title:"Classroom 1", classroom_cap: 28, lecture_cap: 40 },
  { title:"Classroom 2", classroom_cap: 36, lecture_cap: 60 },
  { title:"Classroom 3", classroom_cap: 28, lecture_cap: 40 },
  { title:"Classroom 4", classroom_cap: 28, lecture_cap: 40 },
  { title:"Classroom 5", classroom_cap: 36, lecture_cap: 60 },
  { title:"Classroom 6", classroom_cap: 28, lecture_cap: 40 },
  { title:"Front Lounge", classroom_cap: nil, lecture_cap: 40 },
  { title:"Lobby Classroom", classroom_cap: 20, lecture_cap: nil },
  { title:"12th Floor - Boardroom", classroom_cap: 25, lecture_cap: 60 },
  { title:"12th Floor - Gates Room", classroom_cap: 10, lecture_cap: nil },
  { title:"12th Floor - Jobs Room", classroom_cap: 10, lecture_cap: nil }
])

types = EventType.create([
 { title:"Immersive",color: "#8e44ad"},
 { title:"Part Time Course", color:"#c0392b"},
 { title:"Info Session", color:"#d35400"},
 { title:"C&W", color:"#7f8c8d"},
 { title:"Event", color:"#16a085"},
 { title:"Alumni", color:"#2c3e50"},
 { title:"Internal", color:"#27ae60"}
])


today = DateTime.now.strftime("%e").to_i
7.times do |i|
  i += today
  events = Event.create!([
  {
    title: "NASA 2",
    space: spaces[4],
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 7, minute:0, day: i}),
    event_type: types[3],
    event_style: "Lecture"
  },
  {
    title: "WDI",
    space: spaces[2],
    producer: "Brian Martinowich",
    instructor: "Jesse Shawl",
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 13, minute:0, day: i}),
    approved: true,
    event_type: types[2],
    event_style: "Class"
  },
  {
    title: "UXDI8 Orientation",
    space: spaces[1],
    producer: "Alfonso Bravo",
    instructor: "Jesse Shawl",
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 7, minute:0, day: i}),
    approved: true,
    event_type: types[1],
    event_style: "Class"
  }
  ])

  events[0].notes.create({text: "This is an example note"})
  events[0].notes.create({text: "This is another example note"})
end
