class AttendeesController < ApplicationController
  before_action :authenticate_user!

  def create
    passphrase = params["passphrase"]
    if Event.find_by(passphrase: passphrase) == nil
      flash[:notice] = "Event does not exist"
      redirect_to root_path
    else
      @event = Event.find_by(passphrase: passphrase)
      @attendee = Attendee.new(user_id: current_user.id, event_id: @event.id)
      @attendee.save
      redirect_to event_path(@event)
    end
  end

  private

end
