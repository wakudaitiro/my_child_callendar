class Event < ApplicationRecord
  validates :title, presence: true

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end
