class EventTypesController < ApplicationController
  def update
    @type = EventType.find(params[:id])
    @type.update color: params[:color]
    render json: @type
  end
end