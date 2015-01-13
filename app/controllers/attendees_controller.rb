class AttendeesController < ApplicationController

  def create
    passphrase = params["passphrase"]
    @event = Event.find_by(passphrase: passphrase)
    @attendee = Attendee.new(user_id: current_user.id, event_id: @event.id)
    redirect_to event_path(@event)
  end

  private

  def attendee_params
    params.require(:attendee).permit(:event_id)
  end
end
