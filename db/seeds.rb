Space.destroy_all
EventType.destroy_all
Event.destroy_all
spaces = Space.create([
  { title:"Classroom 1", capacity: 30 },
  { title:"Classroom 2", capacity: 30 },
  { title:"Classroom 3", capacity: 30 },
  { title:"Classroom 4", capacity: 30 },
  { title:"Classroom 5", capacity: 30 },
  { title:"Classroom 6", capacity: 30 },
  { title:"Classroom 13", capacity: 30 }
])

types = EventType.create([
 { color: "#bada55", title:"Immersive"}
])


e = Event.create(
  title: "NASA",
  space: spaces[4],
  start_date: DateTime.now,
  end_date: DateTime.now + 1.hour,
)

e = Event.create(
  title: "NASA 2",
  space: spaces[1],
  start_date: DateTime.now,
  end_date: DateTime.now + 1.hour,
)

e = Event.create(
  title: "WDI",
  space: spaces[2],
  producer: "Brian Martinowich",
  instructor: "Jesse Shawl",
  start_date: DateTime.now.change({hour: 5, minute: 0}),
  end_date: DateTime.now.change({hour: 13, minute:0})
)

e = Event.create(
  title: "UXDI8 Orientation",
  space: spaces[1],
  producer: "Alfonso Bravo",
  instructor: "Jesse Shawl",
  start_date: DateTime.now.change({hour: 10, minute: 0}),
  end_date: DateTime.now.change({hour: 11, minute:0})
)
