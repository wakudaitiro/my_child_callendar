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
    # @date = l Event.start
    start_date = 1.week.ago.beginning_of_day
    end_date = Time.zone.now.end_of_day
    week_ragne = start_date..end_date
    order_icons = 
    # @milk = Event.order('start').where(icon: 'milk.png').pluck(:start).group_by { |start| I18n.l(start) }
    # .map do |date,array|
    #   [date, array.count]
    # end

    # query = "SELECT to_char(start,'MM-DD') AS start_date, count(*)
    #          FROM
    #            events
    #          WHERE icon='milk.png'
    #          GROUP BY to_char(start,'MM-DD'), icon"

    # sql = <<-"EOS"
    # SELECT

    # EOS
    
    # sqlを実行し、取得結果をhashに変換
    # ActiveRecord::Base.connection.select_all(sql)
    # @count = Event.find_by_sql(query)

    # @order_icons.pluck(:start).group_by{ |start| I18n.l(start) }.map do |hour, array|

    # @icons = order_icons.group_by(start)
    # @icons = Event.group_by{ |start| I18n.l(start) }.order("start").pluck(:start, :icon)



#     sql = <<-"EOS"
# SELECT d.start_date, coalesce(r.count, 0) AS count
# FROM (
#   SELECT to_char(s.a, 'MM-DD') AS start_date FROM (
#     SELECT * FROM generate_series(current_timestamp + '-6 days', current_timestamp, '1 day'::interval)
#   ) AS s(a)
# ) AS d
# LEFT JOIN (
#   SELECT to_char(start,'MM-DD') AS start_date, count(*)
#   FROM
#     events
#   WHERE icon='milk.png'
#   GROUP BY to_char(start,'MM-DD'), icon
# ) AS r ON d.start_date = r.start_date
# EOS

#     result = ActiveRecord::Base.connection.select_all(sql)
    result = Event.milk_count
    @milk = result::rows
    # binding.pry 

    




    # @icons = Event.order("start").pluck(:start, :icon)
    # @day_count = @events.group('HOUR(created_at)').count
    # @day_count = @events.joins(:start).group(:start)
    # @week_count =



  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :start, :end, :color, :icon)
  end
end
