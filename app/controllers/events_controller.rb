class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @events = Event.where(start: params[:start]..params[:end])
    json = @events
    render json: json.to_json
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def update
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  def statics
    @milk = Event.day_count_of_week("milk.png")
    @breastfeeding = Event.day_count_of_week("breastfeeding.png")
    @poo = Event.day_count_of_week("poo.png")
    @pee = Event.day_count_of_week("pee.png")
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :start, :end, :color, :icon)
  end
end
