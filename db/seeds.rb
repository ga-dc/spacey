Space.destroy_all
EventType.destroy_all
RecurringEvent.destroy_all
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

recurring_events = RecurringEvent.create([
  {title: "WDI", event_type: types[0]}
])

e = Event.create(
  title: "wdi8",
  space: spaces[0],
  recurring_event: recurring_events[0],
  start: Time.now - 20.days,
  end: Time.now
)

e = Event.create(
  title: "wdi9",
  space: spaces[1],
  recurring_event: recurring_events[0],
  start: Time.now + 20.days,
  end: Time.now + 90.days
)
