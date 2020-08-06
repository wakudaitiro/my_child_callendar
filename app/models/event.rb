class Event < ApplicationRecord
  belongs_to :user

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

  def self.day_count_of_week(icon)
    self.where(icon: icon).group_by_day(:start, time_zone: 'Asia/Tokyo', range: (1.weeks.ago + 1.days).midnight..Time.now.end_of_day, format: "%d").count
  end
end


