class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  has_many :enrollments
  has_many :users, through: :enrollments, dependent: :destroy

  before_create :set_completed_status

  private
  # Below method will set completed status as false,
  # 1) if the end date is before current datetime
  # 2) if `all_day` is "true" and end date is after current date i.e. if end date is
  # 6th March 2020 and current date is 7th March 2020 then set completed status as false
  def set_completed_status
    if all_day
      self.completed = self.end_time.to_date < Date.today
    else
      self.completed = self.end_time < DateTime.now
    end
  end
end
