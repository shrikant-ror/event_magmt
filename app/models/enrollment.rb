class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_commit :set_rsvp

  private
  # Each user’s RSVP is marked in the events csv file, the rsvp should be marked
  # by default the same, but a user having multiple events at the same time can
  # not have rsvp as `yes` for more than one overlapping events.
  # In such case consider the rsvp of last overlapping event to be `yes`
  def set_rsvp
    return unless rsvp == 'yes'
    previous_events = user.events.where("start_time >= ? AND end_time <= ?", event.start_time, event.end_time)
    return if previous_events.blank?
    Enrollment.where(user_id: self.user_id, event_id: previous_events.map(&:id)).update_all(rsvp: 'no')
  end
end
