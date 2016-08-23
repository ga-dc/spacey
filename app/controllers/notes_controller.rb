class NotesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @event.notes.create(note_params.merge(user: current_user))
    redirect_to :back
  end
  def edit
    @event = Event.find(params[:event_id])
    @note = Note.find(params[:id])
  end
  def update
    @event = Event.find(params[:event_id])
    @note = Note.find(params[:id])
    @note.update!(note_params)
    redirect_to event_path(@event)
  end
  def destroy
    @event = Event.find(params[:event_id])
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to event_path(@event)
  end
  private
  def note_params
    params.require(:note).permit(:text, :event_id)
  end
end
