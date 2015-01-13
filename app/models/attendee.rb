class Attendee < ActiveRecord::Base
  belongs_to :users
  belongs_to :events

  validates :user_id, presence: true
  validates :event_id, presence: true
end
