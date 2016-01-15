class ClassroomUtilizationController < ApplicationController
  def index
    @spaces = Space.all
    @events = Event.all
  end
end
