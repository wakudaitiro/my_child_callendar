class Event < ApplicationRecord
  belongs_to :user

  def all_day_event?
    start == start.midnight && self.end == self.end.midnight ? true : false
  end

  def self.day_count_of_week(icon)
    where(icon: icon).group_by_day(:start, time_zone: 'Asia/Tokyo', range: (1.week.ago + 1.day).midnight..Time.zone.now.end_of_day, format: '%d').count
  end
end
