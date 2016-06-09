class RecurringEventsController < ApplicationController
  def new
    @recurring_event = RecurringEvent.new
  end
  def create
    # get start/end date from params
  end
  def edit
    @recurring_event = RecurringEvent.find(params[:id])
  end
  def update
  end
  def destroy
  end
end
