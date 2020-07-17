class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

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
    # @milk = Event.milk_count::rows
    # @pee = Event.pee_count::rows
    # @poo = Event.poo_count::rows
    # @milk = Event.order('start').where(icon: 'milk.png').pluck(:start).group_by { |start| I18n.l(start) }
    # .map do |date,array|
    #   [date, array.count]
    # @milk = Event.where(icon: 'milk.png').group_by_day(:start, time_zone: 'Asia/Tokyo', range: (1.weeks.ago + 1.days).midnight..Time.now.end_of_day, format: "%d").count
    @milk = Event.day_count_of_week("milk.png")
    # @milk = Event.where(icon: 'pee.png')
    # @milk = Event.where(icon: 'poo.png')


    end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :start, :end, :color, :icon)
  end
end
