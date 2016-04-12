class NotesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @event.notes.create(note_params)
    redirect_to :back
  end
  private
  def note_params
    params.require(:note).permit(:text, :event_id)
  end
end