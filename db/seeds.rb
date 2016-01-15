spaces = Space.create([
  { title:"Classroom 4", capacity: 30 }
])

types = EventType.create([
 { color: "#bada55", title:"Immersive"}
])

recurring_events = RecurringEvent.create([
  {title: "WDI", event_type: types[0]}
])

e = Event.create(
  title: "wdi8",
  space: spaces[0],
  recurring_event: recurring_events[0],
  start: Date.new,
  end: Date.new
)
