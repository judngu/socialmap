class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def show
    @event = Event.find_by(id: params[:id])
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
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    @user = @event.user
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event sucessfully updated."
    else
      render :edit
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :location, :address,:city, :state, :question, :passphrase, :description)
  end
end
