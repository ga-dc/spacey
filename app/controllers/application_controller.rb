class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :set_event, :queue_count

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def set_event
    @event = Event.last unless @event
  end
  def queue_count
    @queue_count = Event.unapproved.count
  end
end
