spaces = Space.create([
  { title:"Classroom 4", capacity: 30 }
])

types = Type.create([
 { color: "#bada55", title:"Immersive"}
])

recurring_events = RecurringEvent.create([
  {title: "WDI", type: types[0]}
])

e = Event.create(
  title: "wdi8",
  space: spaces[0],
  recurring_event: recurring_events[0]
  start: Date.now,
  end: Date.now
)
