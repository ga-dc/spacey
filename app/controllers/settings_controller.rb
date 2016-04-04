class SettingsController < ApplicationController
  def index
    @event_types = EventType.all
  end
end