class EventsController < ApplicationController
  before_action :authenticate_user!

  def show
    @event = Event.find_by(id: params[:id])
    @pick = Pick.new
    @event_attendees = @event.other_attendees(current_user)
  end 

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = "Event sucessfully created."
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])

    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event sucessfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Event sucessfully deleted."
  end

  private
  
  def event_params
    params.require(:event).permit(:name, :location, :address,:city, :state, :zipcode, :question, :passphrase, :description)
  end
end
