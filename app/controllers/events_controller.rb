class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(id: params[:id])
    @pick = Pick.new
    @event_attendees = @event.users.all_except(current_user)
  end 

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
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
    @user = @event.user
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event sucessfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
      if @event.destroy
        redirect_to events_path, notice: "Event sucessfully deleted."
      else
        redirect_to event_path, notice: "Event not deleted"
      end
  end

  private
  def event_params
    params.require(:event).permit(:name, :location, :address,:city,
     :state, :zipcode, :question, :passphrase, :description)
  end
end
