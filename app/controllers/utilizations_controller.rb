class UtilizationsController < ApplicationController
  def index
    @by_day = by_day Date.today
    @by_week = by_week Date.today
    weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    today_index = DateTime.now.wday
    @sorted_weekdays = weekdays.rotate(today_index - 1)
  end

  def by_day datetime
    @utils = {}
    Space.all.each do |space|
      hours_filled = 0
      events = space.events.where("start_date > ? AND end_date < ?", datetime, datetime + 1.day)
      events.each do |event|
        hours_filled += ((event.end_date - event.start_date) / 1.hour).round
      end
      @utils[space.title] = (hours_filled.to_f / 24.to_f).round(2)
    end
    @utils
  end

  def by_week datetime
    @utils = {}
    Space.all.each do |space|
      @utils[space.title] = []
      7.times do |i|
        hours = 0
        # get all events for a space
	events = space.events.where("start_date > ? AND end_date < ?", datetime + (i).day, datetime + (i+1).day)
	events.each do |event|
          # add hours filled for a space
	  hours += ((event.end_date - event.start_date) / 1.hour).round
	end
        @utils[space.title] << (100 * hours.to_f / 24.to_f).round(2)
      end
    end
    @organized = []
    @utils.each do |space, hours|
      @organized << {name: space, data: hours}
    end
    @organized
  end

end
