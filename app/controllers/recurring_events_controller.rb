class RecurringEventsController < ApplicationController
  def destroy
    @recurring_event = RecurringEvent.find(params[:id])
    @recurring_event.destroy
    redirect_to root_path
  end
end