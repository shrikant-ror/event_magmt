class EventsController < ApplicationController
  def index
    byebug
    if permit_params[:start_time] && permit_params[:end_time]
      @events = Event.where('start_time >= ? AND end_time <= ?', Date.parse(permit_params[:start_time]), Date.parse(permit_params[:end_time]))
    else
      @events = Event.all
    end
  end

  private
  def permit_params
    params.permit(:start_time, :end_time)
  end
end
