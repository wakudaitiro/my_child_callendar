class Event < ApplicationRecord
  # validates :title, presence: true

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

private

def self.milk_count
  sql = <<-"EOS"
  SELECT d.start_date, coalesce(r.count, 0) AS count
  FROM (
    SELECT to_char(s.a, 'MM-DD') AS start_date FROM (
      SELECT * FROM generate_series(current_timestamp + '-6 days', current_timestamp, '1 day'::interval)
    ) AS s(a)
  ) AS d
  LEFT JOIN (
    SELECT to_char(start,'MM-DD') AS start_date, count(*)
    FROM
      events
    WHERE icon='milk.png'
    GROUP BY to_char(start,'MM-DD'), icon
  ) AS r ON d.start_date = r.start_date
  EOS
  
   ActiveRecord::Base.connection.select_all(sql)
end



# SELECT d.start_date, coalesce(r.count, 0) AS count
# FROM (
#   SELECT to_char(s.a, 'MM-DD') AS start_date FROM (
#     SELECT * FROM generate_series(current_timestamp + '-6 days', current_timestamp::timestamp, '1 day'::interval)
#   ) AS s(a)
# ) AS d
# LEFT JOIN (
#   SELECT to_char(start,'MM-DD') AS start_date, count(*)
#   FROM
#     events
#   WHERE icon='milk.png'
#   GROUP BY to_char(start,'MM-DD'), icon
# ) AS r ON d.start_date = r.start_date;


# SELECT d.start_date, coalesce(r.count, 0) AS count
# FROM (
#   SELECT s.a AS start_date FROM (
#     SELECT * FROM generate_series(current_timestamp + '-6 days', current_timestamp::timestamp, '1 day'::interval)
#   ) AS s(a)
# ) AS d
# LEFT JOIN (
#   SELECT start AS start_date, count(*)
#   FROM
#     events
#   WHERE icon='milk.png'
#   GROUP BY start, icon
# ) AS r ON d.start_date = r.start_date;







end