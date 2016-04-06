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
 { title:"Immersive",color: "#8e44ad"},
 { title:"Part Time Course", color:"#c0392b"},
 { title:"Info Session", color:"#d35400"},
 { title:"C&W", color:"#7f8c8d"},
 { title:"Event", color:"#16a085"},
 { title:"Alumni", color:"#2c3e50"},
 { title:"Internal", color:"#27ae60"}
])


e = Event.create!(
  title: "NASA",
  space: spaces[4],
  start_date: DateTime.now.change({hour: 5, minute: 0}),
  end_date: DateTime.now.change({hour: 7, minute:0}),
)

events = Event.create!([
{
  title: "NASA 2",
  space: spaces[1],
  start_date: DateTime.now.change({hour: 5, minute: 0}),
  end_date: DateTime.now.change({hour: 7, minute:0}),
  event_type: types[3]

},
{
  title: "WDI",
  space: spaces[2],
  producer: "Brian Martinowich",
  instructor: "Jesse Shawl",
  start_date: DateTime.now.change({hour: 5, minute: 0}),
  end_date: DateTime.now.change({hour: 13, minute:0}),
  event_type: types[2]
},
{
  title: "UXDI8 Orientation",
  space: spaces[1],
  producer: "Alfonso Bravo",
  instructor: "Jesse Shawl",
  start_date: DateTime.now.change({hour: 10, minute: 0}),
  end_date: DateTime.now.change({hour: 11, minute:0}),
  event_type: types[1]
}
])

events[0].notes.create({text: "This is an example note"})
events[0].notes.create({text: "This is another example note"})
