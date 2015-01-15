class PicksController < ApplicationController
  
  def index
    @event  = Event.find(params[:event_id])
    @picks = @event.picks
    Pick.count_picks(@event)
  end

  def create
    @pick = Pick.new(pick_params)
    @pick.user_id = current_user.id
    @pick.event_id = params[:event_id]
    if @pick.save
      flash[:notice] = "User connection added."
      redirect_to event_path(params[:event_id])
    else
    end
  end

  private

  def pick_params
    params.require(:pick).permit(:user_id, :event_id, :value, :picked_user)
  end

end
