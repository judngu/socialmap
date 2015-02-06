class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true

  def pick_count
    event.picks.where(picked_user: self).count
  end
end
