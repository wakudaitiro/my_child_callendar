class Event < ApplicationRecord
  # validates :title, presence: true

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

private
 
  def self.day_count_of_week(icon)
    self.where(icon: icon).group_by_day(:start, time_zone: 'Asia/Tokyo', range: (1.weeks.ago + 1.days).midnight..Time.now.end_of_day, format: "%d").count
  end

  # def self.pee_count
  #   sql = <<-"EOS"
  #   SELECT d.start_date, coalesce(r.count, 0) AS count
  #   FROM (
  #     SELECT to_char(s.a, 'MM/DD') AS start_date FROM (
  #       SELECT * FROM generate_series(current_timestamp + '-6 days', current_timestamp, '1 day'::interval)
  #     ) AS s(a)
  #   ) AS d
  #   LEFT JOIN (
  #     SELECT to_char(start,'MM/DD') AS start_date, count(*)
  #     FROM
  #       events
  #     WHERE icon='pee.png'
  #     GROUP BY to_char(start,'MM/DD'), icon
  #   ) AS r ON d.start_date = r.start_date
  #   EOS
  #   ActiveRecord::Base.connection.select_all(sql)
  # end

  # def self.poo_count
  #   sql = <<-"EOS"
  #   SELECT d.start_date, coalesce(r.count, 0) AS count
  #   FROM (
  #     SELECT to_char(s.a, 'MM/DD') AS start_date FROM (
  #       SELECT * FROM generate_series(current_timestamp + '-6 days', current_timestamp, '1 day'::interval)
  #     ) AS s(a)
  #   ) AS d
  #   LEFT JOIN (
  #     SELECT to_char(start,'MM/DD') AS start_date, count(*)
  #     FROM
  #       events
  #     WHERE icon='poo.png'
  #     GROUP BY to_char(start,'MM/DD'),  icon
  #   ) AS r ON d.start_date = r.start_date
  #   EOS
  #   ActiveRecord::Base.connection.select_all(sql)
  # end
end


