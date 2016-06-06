Note.destroy_all
EventType.destroy_all
Event.destroy_all
Space.destroy_all
spaces = Space.create([
  { title:"Classroom 1", capacity: 30 },
  { title:"Classroom 2", capacity: 30 },
  { title:"Classroom 3", capacity: 30 },
  { title:"Classroom 4", capacity: 30 },
  { title:"Classroom 5", capacity: 30 },
  { title:"Classroom 6", capacity: 30 },
  { title:"Front Lounge", capacity: 30 },
  { title:"Lobby Classroom", capacity: 30 },
  { title:"Jobs Room", capacity: 30 },
  { title:"Gates Room", capacity: 30 },
  { title:"Board Room", capacity: 30 },
  { title:"12 Floor A Space", capacity: 30 },
  { title:"12 Floor B Space", capacity: 30 },
  { title:"12 Floor C Space", capacity: 30 },
  { title:"OpenGovHub", capacity: 30 }
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
  e = Event.create!(
    title: "NASA",
    space: spaces[4],
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 7, minute:0, day: i}),
  )
  events = Event.create!([
  {
    title: "NASA 2",
    space: spaces[1],
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 7, minute:0, day: i}),
    event_type: types[3]
  },
  {
    title: "WDI",
    space: spaces[2],
    producer: "Brian Martinowich",
    instructor: "Jesse Shawl",
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 13, minute:0, day: i}),
    approved: true,
    event_type: types[2]
  },
  {
    title: "UXDI8 Orientation",
    space: spaces[1],
    producer: "Alfonso Bravo",
    instructor: "Jesse Shawl",
    start_date: DateTime.now.change({hour: 5, minute: 0, day: i}),
    end_date: DateTime.now.change({hour: 7, minute:0, day: i}),
    approved: true,
    event_type: types[1]
  }
  ])

  events[0].notes.create({text: "This is an example note"})
  events[0].notes.create({text: "This is another example note"})
end
